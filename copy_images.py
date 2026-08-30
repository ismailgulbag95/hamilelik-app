import os
import shutil
import glob

brain_dir = r"C:\Users\ismai\.gemini\antigravity-ide\brain\c0e508e4-b79f-4fce-8d71-f1f92fed0f88"
target_dir = r"d:\github\hamilelik-app\assets\images"
os.makedirs(target_dir, exist_ok=True)

for stage in range(1, 7):
    pattern = os.path.join(brain_dir, f"womb_stage_{stage}_*.jpg")
    matches = glob.glob(pattern)
    if matches:
        matches.sort(key=os.path.getmtime, reverse=True)
        src = matches[0]
        dst = os.path.join(target_dir, f"womb_stage{stage}.jpg")
        shutil.copy2(src, dst)
        print(f"Copied Stage {stage}: {src} -> {dst} ({os.path.getsize(dst)} bytes)")

print("All stage images copied successfully!")
