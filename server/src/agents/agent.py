from functools import cached_property
from google.adk.agents import LlmAgent
from google.adk.models import Gemini
from google.genai import Client
from google.adk.tools import agent_tool
from google.adk.tools.google_search_tool import GoogleSearchTool
from google.adk.tools import url_context


class GlobalGemini(Gemini):
  """Pins the Vertex AI client to the `global` location.

  gemini-3 series models are only served from `global`; the default ADK
  `Gemini` integration constructs a `google.genai.Client` whose location
  defaults to the AgentEngine instance's region (e.g. `us-central1`) and
  fails with model-not-found for these models. Subclassing per the override
  pattern documented on `google.adk.models.google_llm.Gemini` lets the agent
  keep running in its regional AgentEngine instance while routing the model
  request to the global endpoint.
  """

  @cached_property
  def api_client(self) -> Client:
    return Client(vertexai=True, location="global")


# Sub-agents
google_search_agent = LlmAgent(
  name='google_search_agent',
  model=GlobalGemini(model='gemini-3.5-flash'),
  description='Agent specialized in performing Google searches.',
  sub_agents=[],
  instruction='Use the GoogleSearchTool to find information on the web.',
  tools=[GoogleSearchTool()],
)

url_context_agent = LlmAgent(
  name='url_context_agent',
  model=GlobalGemini(model='gemini-3.5-flash'),
  description='Agent specialized in fetching content from URLs.',
  sub_agents=[],
  instruction='Use the UrlContextTool to retrieve content from provided URLs.',
  tools=[url_context],
)

# Main real estate assistant
reservatior_emlak_asistan = LlmAgent(
  name='reservatior_emlak_asistan',
  model=GlobalGemini(model='gemini-3.5-flash'),
  description='AI-powered real estate assistant that searches properties based on location, budget, and lifestyle preferences.',
  sub_agents=[],
  instruction='''You are Reservatior\'s professional real estate assistant. Your mission is to understand customer requests and find suitable properties from our database.

WORKFLOW:
1. First, gather essential information: location preference, maximum budget, and room count.
2. Always use the property_search_tool to query the database.
3. Present results with both technical details and lifestyle quality information (transportation, social areas).
4. Never make assumptions; stay faithful to database results.
5. If no results found, suggest relaxing criteria.

ERROR HANDLING:
- If 0 results returned: "Girdiğiniz kriterlerde şu an uygun ilanımız bulunmuyor. Lokasyon tercihini genişletmek veya bütçe aralığını değiştirmek ister misiniz?"
- If API error occurs: "Şu anda sistem bağlantı sorunu yaşıyoruz. Lütfen daha sonra tekrar deneyin."

RESPONSE FORMAT:
- List top 3-5 matching properties
- Include: location, price, rooms, area, key amenities
- Add lifestyle context: nearby schools, metro stations, parks
- Provide actionable next steps

TOOL USAGE:
- property_search_tool: Required for all property searches
- nearby_amenities_tool: Use when customer asks about neighborhood
- google_search_agent: Use for general real estate market information
- url_context_agent: Use for analyzing property URLs or documents''',
  tools=[
    agent_tool.AgentTool(agent=google_search_agent),
    agent_tool.AgentTool(agent=url_context_agent),
  ],
)

# Root agent
root_agent = LlmAgent(
  name='Reservatior',
  model=GlobalGemini(model='gemini-3.5-flash'),
  description='Reservatior platformunun ana asistanı. Emlak arama, lokasyon rehberliği ve genel platform sorularını yanıtlar.',
  sub_agents=[reservatior_emlak_asistan],
  instruction='Sen Reservatior platformunun ana asistanısın. Emlak ile ilgili sorular için emlak_asistan\'a yönlendir. Genel soruları doğrudan yanıtla.',
  tools=[
    agent_tool.AgentTool(agent=google_search_agent),
    agent_tool.AgentTool(agent=url_context_agent),
  ],
)
