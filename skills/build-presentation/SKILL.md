---
name: build-presentation
description: Generate polished technical presentations (.pptx) with visual-first layouts, Feynman-style speaker notes, and programmatic diagrams. Use when the user asks to create, draft, build, or export a presentation, slide deck, or PPTX. Trigger keywords - presentation, slides, pptx, deck, slide deck, build deck, create slides, powerpoint.
---

# Build Presentation

Generate polished technical presentations (.pptx) using python-pptx. Every presentation follows strict design rules for visual clarity, scannable content, and speaker-ready notes.

## When This Skill Triggers

- User asks to create, build, draft, or export a presentation, slide deck, or PPTX
- User asks to "make slides for X", "build a deck on X", "create a presentation about X"
- User provides content (paper, wiki page, transcript, notes) and asks for a presentation version

## Non-Negotiable Rules

### 1. Opening Slide — Why Should I Care
The very first content slide (after the title) must explain why the audience should care. Frame the problem or opportunity before diving into the solution. The audience decides in the first 60 seconds whether to pay attention.

### 2. No Text Walls
- Maximum **35 words per slide** — no exceptions
- Never use dense text paragraphs
- Use clean, side-by-side asymmetric layouts
- Even text-only slides must use visual structure — colored boxes, columns, arrows, callout shapes, or contrasting backgrounds
- A slide with just stacked lines of text is **always wrong**

### 3. Visual-First Layouts
Every single slide must explicitly reserve a column or block for a picture, architecture diagram, component layout, or icon array.

**Diagram sourcing priority:**
1. **Extract figures from the source material** (papers, blog posts, datasheets) — always try this first
2. **Only create original diagrams when no source figure exists**
3. When creating diagrams, generate them programmatically (matplotlib, graphviz, PIL, etc.) and embed the resulting PNGs
4. **Never use ASCII art or text-based diagrams** — always produce actual PNG images

### 4. Slide Jargon Filter
All presentations are highly technical, but slides must remain clean and scannable. Do not include unexplained technical jargon or dense acronyms directly on the slide surface. Push jargon to speaker notes.

### 5. Feynman-Style Speaker Notes
Move explanations, deep-dive content, and jargon translations entirely into the slide metadata / speaker notes layer. Frame the notes using the Feynman technique (teaching a smart 12-year-old) with this strict 3-part layout:

1. **The Plain-English Anchor:** 1-2 sentence core concept using a real-world analogy.
2. **The Visual Translation:** Direct guidance mapping the talk track to the slide image (e.g., "Point to the left box...").
3. **The Impact Hook:** The real engineering or business consequence.

### 6. No Questions Slides
Don't add separate "Questions?" or "Discussion" slides — they break flow. Instead, add a subtle discussion icon (small chat bubble emoji or shape) to the bottom-right corner of section-ending slides as a visual cue to pause.

- For a 30-minute talk: mark 2–3 slides
- For longer talks: one every 8–10 minutes
- Add a speaker note reminding the presenter to pause for questions at those slides

### 7. Closing Slide — The One Thing
The final slide must always say:

> *"If you don't remember anything from this presentation, remember this:"*

Followed by the **single most important takeaway**. Distill the entire talk into one sentence the audience will carry out of the room.

## Editing Existing Presentations

When modifying slides in an existing presentation:

- **Preserve the user's manual layout adjustments** — only change the specific content requested
- Do NOT reposition or resize images unless asked
- Do NOT rebuild slides from scratch unless explicitly asked
- If you must rebuild a slide, warn the user that their layout tweaks will be lost
- Target only the specific text boxes or shapes that need changing

## Technical Implementation

### Generating PPTX
Use `python-pptx` for all slide generation. Write a Python script that:
1. Creates slides with the layout rules above
2. Generates diagrams as PNGs (matplotlib/graphviz/PIL) and embeds them
3. Adds speaker notes to every content slide
4. Saves the .pptx file

### Diagram Generation
```python
# Always use programmatic diagrams, never ASCII
import matplotlib.pyplot as plt
import matplotlib.patches as patches

fig, ax = plt.subplots(figsize=(10, 6))
# ... draw boxes, arrows, labels ...
plt.savefig('diagram.png', dpi=150, bbox_inches='tight', transparent=True)
```

### Slide Structure Template
```python
from pptx import Presentation
from pptx.util import Inches, Pt

prs = Presentation()
slide = prs.slides.add_slide(prs.slide_layouts[5])  # Blank layout

# Left column: text (35 words max)
# Right column: image/diagram
# Speaker notes: Feynman 3-part format

notes_slide = slide.notes_slide
notes_slide.notes_text_frame.text = """
Plain-English Anchor: [analogy]
Visual Translation: [point to X on the diagram]
Impact Hook: [business/engineering consequence]
"""
```

## Process

1. **Understand the content** — read the source material thoroughly
2. **Plan the narrative** — what's the story arc? (problem → insight → mechanism → payoff)
3. **Design ~10 slides** — one idea per slide, visual-first
4. **Generate diagrams** — extract from sources first, create original only if needed
5. **Write speaker notes** — Feynman 3-part format for every content slide
6. **Build the PPTX** — run the script, verify output
7. **Open for review** — `open output.pptx`
