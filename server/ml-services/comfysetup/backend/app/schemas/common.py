from enum import Enum

class RoomType(str, Enum):
    LIVING_ROOM = "living-room"
    BEDROOM = "bedroom"
    DINING_ROOM = "dining-room"
    KITCHEN = "kitchen"
    OFFICE = "office"
    BATHROOM = "bathroom"
    OUTDOOR = "outdoor"
    KIDS_ROOM = "kids-room"
    HOME_GYM = "home-gym"
    ADD_ROOM = "add-room"

class DesignStyle(str, Enum):
    MODERN_MINIMALIST = "modern-minimalist"
    SCANDINAVIAN = "scandinavian"
    INDUSTRIAL = "industrial"
    MID_CENTURY_MODERN = "mid-century-modern"
    BOHEMIAN = "bohemian"
    CONTEMPORARY = "contemporary"
    TRADITIONAL = "traditional"
    COASTAL = "coastal"
    FARMHOUSE = "farmhouse"
    LUXURY = "luxury"
    CYBERPUNK = "cyberpunk"
    JAPANESE = "japanese"
    BIOPHILIC = "biophilic"
    ART_DECO = "art-deco"
