from PIL import Image

def crop_pattern(image_path, output_path):
    img = Image.open(image_path)
    # The image is 1024x1024. The top left corner has a clean geometric pattern.
    # Let's crop from 0,0 to 300,300
    cropped = img.crop((0, 0, 300, 300))
    cropped.save(output_path)
    print(f"Pattern saved to {output_path}")

crop_pattern('/Users/os2026/Downloads/Reservatior/client/public/uploads/email-banner.png', '/Users/os2026/Downloads/Reservatior/client/public/uploads/email-bg-pattern.png')
