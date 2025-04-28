from PIL import Image
import os

# Set the folder path
folder_path = os.getcwd()

# Set the desired width and height
new_width = 320
new_height = 240

# Loop through all image files in the folder
for filename in os.listdir(folder_path):
    if filename.lower().endswith(('.png', '.jpg', '.jpeg', '.gif')): # Add other formats if needed
        try:
            filepath = os.path.join(folder_path, filename)
            img = Image.open(filepath)

            # Resize the image
            img = img.resize((new_width, new_height), Image.LANCZOS)

            # Save the resized image (optional: create a new folder or overwrite)
            new_filepath = os.path.join(folder_path, filename) # Example: save in a new folder
            # new_filepath = os.path.join(folder_path, filename) # Example: Overwrite original file (be careful!)
            img.save(new_filepath)

            print(f"Resized: {filename}")
        except Exception as e:
            print(f"Error processing {filename}: {e}")