import re

with open('lib/features/dashboard/presentation/screens/dashboard_screen.dart', 'r') as f:
    content = f.read()

# The methods to move start at "Widget _buildActiveAiTasks" and go to the end of the file except the very last brace
start_idx = content.find('  Widget _buildActiveAiTasks')
if start_idx != -1:
    methods_str = content[start_idx:-2] # skip last "}\n"
    
    # remove from DocumentAnalysisQuickView
    new_content = content[:start_idx] + "}\n"
    
    # Insert right before the closing brace of DashboardScreen
    # DashboardScreen closes just before class AgentPerformanceStats
    insert_idx = new_content.find('class AgentPerformanceStats')
    
    # find the brace before insert_idx
    brace_idx = new_content.rfind('}', 0, insert_idx)
    
    final_content = new_content[:brace_idx] + methods_str + new_content[brace_idx:]
    
    final_content = final_content.replace('Widget _buildComplianceSecurity(ThemeAwareColors colors)', 'Widget _buildComplianceSecurity(BuildContext context, ThemeAwareColors colors)')
    
    with open('lib/features/dashboard/presentation/screens/dashboard_screen.dart', 'w') as f:
        f.write(final_content)
        
    print("Fixed!")
else:
    print("Could not find methods")
