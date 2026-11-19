import re

with open("scratch/step_3888_full.txt", "r", encoding="utf-8") as f:
    text = f.read()

sections = re.split(r'##\s+', text)
print(f"Total sections: {len(sections)}")
for i, sec in enumerate(sections):
    lines = sec.strip().split('\n')
    title = lines[0] if lines else "EMPTY"
    print(f"Section {i}: {title[:80]} ({len(lines)} lines)")

with open("scratch/step_3888_sections.txt", "w", encoding="utf-8") as out:
    for i, sec in enumerate(sections):
        out.write(f"\n{'='*50}\nSECTION {i}\n{'='*50}\n{sec}\n")

print("Saved to scratch/step_3888_sections.txt")
