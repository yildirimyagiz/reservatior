from PIL import Image, ImageChops

def crop_banner(image_path, output_path):
    img = Image.open(image_path)
    # The image is 1024x1024. The banner is in the middle.
    # Let's crop the center horizontal strip
    # Approximate coords for the banner inside the 1024x1024 square
    # We can crop from y=300 to y=724
    width, height = img.size
    left = int(width * 0.05)
    top = int(height * 0.28)
    right = int(width * 0.95)
    bottom = int(height * 0.72)
    
    cropped = img.crop((left, top, right, bottom))
    cropped.save(output_path)
    print(f"Cropped saved to {output_path}")

crop_banner('/Users/os2026/Downloads/Reservatior/client/public/uploads/email-banner.png', '/Users/os2026/Downloads/Reservatior/client/public/uploads/email-banner-cropped.png')
