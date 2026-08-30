import urllib.request
import os
from PIL import Image

def download_and_process():
    out_dir = r"d:\github\hamilelik-app\assets\images"
    os.makedirs(out_dir, exist_ok=True)

    urls = {
        "womb_stage1.jpg": "https://upload.wikimedia.org/wikipedia/commons/thumb/c/cb/Human_Embryo_-_approximately_8_weeks_estimated_gestational_age.jpg/640px-Human_Embryo_-_approximately_8_weeks_estimated_gestational_age.jpg",
        "womb_stage2.jpg": "https://upload.wikimedia.org/wikipedia/commons/thumb/3/30/Human_Fetus_10_Weeks_with_Amniotic_Sac.jpg/640px-Human_Fetus_10_Weeks_with_Amniotic_Sac.jpg",
        "womb_stage3.jpg": "https://upload.wikimedia.org/wikipedia/commons/thumb/8/87/Human_fetus_17_weeks.jpg/640px-Human_fetus_17_weeks.jpg",
        "womb_stage4.jpg": "https://upload.wikimedia.org/wikipedia/commons/thumb/7/74/Fetus_in_utero.jpg/640px-Fetus_in_utero.jpg",
    }

    headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)'}

    for filename, url in urls.items():
        file_path = os.path.join(out_dir, filename)
        try:
            req = urllib.request.Request(url, headers=headers)
            with urllib.request.urlopen(req, timeout=10) as response, open(file_path, 'wb') as out_file:
                out_file.write(response.read())
            print(f"Downloaded: {filename} from {url}")
        except Exception as e:
            print(f"Failed to download {filename}: {e}")

if __name__ == "__main__":
    download_and_process()
