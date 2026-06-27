from PIL import Image

def crop_banner(image_path, output_path):
    img = Image.open(image_path)
    # The image is 1024x1024. There are two banners.
    # The top banner is from y=60 to y=470 approx.
    width, height = img.size
    left = int(width * 0.05)
    top = int(height * 0.05)
    right = int(width * 0.95)
    bottom = int(height * 0.47)
    
    cropped = img.crop((left, top, right, bottom))
    cropped.save(output_path)
    print(f"Cropped saved to {output_path}")

crop_banner('/Users/os2026/.gemini/antigravity-ide/brain/ee24a820-98fa-400b-aab0-46cd3bbf521f/blue_gold_banner_1781935988527.png', '/Users/os2026/Downloads/Reservatior/client/public/uploads/email-banner-cropped.png')
