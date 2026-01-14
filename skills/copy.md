# Copy & UX Writing Skill

## Purpose
Create clear, concise, and user-friendly copy for the Tami application in Hebrew and English.

## Guidelines

### Hebrew UX Writing Principles
1. **Direct and concise** - Hebrew users prefer straightforward language
2. **Formal but friendly** - Use "אתה/את" forms, not overly formal
3. **Action-oriented** - Start CTAs with verbs
4. **RTL-aware** - Consider text direction in UI placement

### Microcopy Patterns

#### Button Labels
- Primary actions: Clear verb + noun ("העלה הקלטה", "התחל שיחה")
- Secondary actions: Shorter ("ביטול", "שמור")
- Destructive: Include warning ("מחק לצמיתות")

#### Error Messages
```
Structure: [What happened] + [What to do]
Example: "הקובץ גדול מדי. נסה להעלות קובץ עד 100MB."
```

#### Empty States
```
Structure: [State description] + [Value proposition] + [CTA]
Example:
  Title: "אין שיחות עדיין"
  Description: "התחל להקליט או להעלות פגישות"
  CTA: "שיחה חדשה"
```

#### Loading States
- Short waits: "טוען..."
- Long processes: "מעבד את ההקלטה... זה עשוי לקחת כדקה"
- Progress: "מתמלל... 45%"

#### Success Messages
- Immediate confirmation: "השיחה נשמרה בהצלחה"
- Celebratory (sparingly): "מעולה! התמלול מוכן"

### Tone Guidelines

| Context | Tone | Example |
|---------|------|---------|
| Onboarding | Welcoming, helpful | "ברוך הבא! בוא נתחיל" |
| Errors | Calm, solution-focused | "משהו השתבש. נסה שוב" |
| Success | Brief, positive | "נשמר!" |
| Empty states | Encouraging | "עוד לא הקלטת? קל להתחיל" |
| Destructive | Clear, cautious | "בטוח? פעולה זו לא ניתנת לביטול" |

### Common Terms Dictionary

| English | Hebrew | Notes |
|---------|--------|-------|
| Conversation | שיחה | Not "פגישה" (meeting) |
| Transcript | תמלול | |
| Summary | סיכום | |
| Recording | הקלטה | |
| Speaker | דובר | |
| Action item | משימה | |
| Tag | תגית | |
| Entity | ישות | For extracted data |
| Search | חיפוש | |

## When to Use This Skill
- Writing new UI text
- Creating error messages
- Designing empty states
- Writing tooltips and help text
- Creating onboarding flows
- Localizing features
