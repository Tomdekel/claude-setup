# Design & UI/UX Skill

## Purpose
Create consistent, modern, and accessible UI components following the Narrative-inspired design system.

## Design System

### Color Palette (OkLch)

```css
/* Primary */
--primary: oklch(0.205 0 0);         /* Near black */
--primary-foreground: oklch(0.98 0 0); /* Near white */

/* Backgrounds */
--background: oklch(1 0 0);           /* White */
--background-secondary: oklch(0.98 0 0); /* Light gray */
--sidebar: oklch(0.15 0 0);           /* Dark sidebar */

/* Cards */
--card: oklch(1 0 0);
--card-hover: oklch(0.98 0 0);
--card-border: oklch(0.9 0 0);

/* Text */
--text-primary: oklch(0.15 0 0);
--text-secondary: oklch(0.45 0 0);
--text-muted: oklch(0.6 0 0);

/* Status Colors */
--status-success: oklch(0.7 0.15 145);   /* Green */
--status-warning: oklch(0.8 0.15 85);    /* Yellow */
--status-error: oklch(0.65 0.2 25);      /* Red */
--status-info: oklch(0.65 0.15 250);     /* Blue */
--status-pending: oklch(0.7 0 0);        /* Gray */

/* Entity Type Colors */
--entity-person: oklch(0.7 0.12 250);    /* Blue */
--entity-org: oklch(0.7 0.12 300);       /* Purple */
--entity-project: oklch(0.7 0.12 145);   /* Green */
--entity-date: oklch(0.75 0.12 85);      /* Yellow */
--entity-location: oklch(0.7 0.12 30);   /* Orange */
--entity-price: oklch(0.7 0.12 165);     /* Teal */

/* Accents */
--accent: oklch(0.6 0.15 250);           /* Blue accent */
--accent-gradient: linear-gradient(to right, oklch(0.6 0.15 250), oklch(0.55 0.18 280));
```

### Typography

```css
/* Font Stack (Hebrew-first) */
font-family: 'Heebo', 'Inter', system-ui, sans-serif;

/* Scale */
--text-xs: 0.75rem;    /* 12px */
--text-sm: 0.875rem;   /* 14px */
--text-base: 1rem;     /* 16px */
--text-lg: 1.125rem;   /* 18px */
--text-xl: 1.25rem;    /* 20px */
--text-2xl: 1.5rem;    /* 24px */
--text-3xl: 1.875rem;  /* 30px */

/* Weights */
--font-normal: 400;
--font-medium: 500;
--font-semibold: 600;
--font-bold: 700;
```

### Spacing Scale (Tailwind)
- `space-1`: 0.25rem (4px)
- `space-2`: 0.5rem (8px)
- `space-3`: 0.75rem (12px)
- `space-4`: 1rem (16px)
- `space-6`: 1.5rem (24px)
- `space-8`: 2rem (32px)
- `space-12`: 3rem (48px)

### Component Patterns

#### Cards
```tsx
<Card className="bg-white rounded-xl shadow-sm border border-gray-100 hover:shadow-md transition-shadow">
  <CardHeader className="p-4 border-b border-gray-50">
    <CardTitle className="text-lg font-semibold" />
  </CardHeader>
  <CardContent className="p-4" />
</Card>
```

#### Buttons
```tsx
// Primary
<Button className="bg-gradient-to-r from-blue-600 to-indigo-600 text-white rounded-lg px-4 py-2 font-medium hover:opacity-90" />

// Secondary
<Button variant="outline" className="border-gray-200 text-gray-700 hover:bg-gray-50" />

// Ghost
<Button variant="ghost" className="text-gray-600 hover:text-gray-900 hover:bg-gray-100" />

// Destructive
<Button variant="destructive" className="bg-red-500 text-white hover:bg-red-600" />
```

#### Status Badges
```tsx
<Badge variant="success">הושלם</Badge>   // Green
<Badge variant="warning">מעבד</Badge>    // Yellow
<Badge variant="error">נכשל</Badge>      // Red
<Badge variant="default">ממתין</Badge>   // Gray
```

#### Sidebar Navigation
```tsx
<nav className="w-64 bg-gray-900 text-white h-screen fixed">
  <NavItem icon={Home} active>בית</NavItem>
  <NavItem icon={MessageSquare}>שיחות</NavItem>
  <NavItem icon={Search}>חיפוש</NavItem>
  <NavItem icon={Tag}>תגיות</NavItem>
  <NavItem icon={Users}>ישויות</NavItem>
</nav>
```

### Layout Guidelines

#### Desktop (≥1024px)
- Fixed sidebar: 256px width
- Main content: max-w-4xl, centered
- Padding: p-8

#### Tablet (768px-1023px)
- Collapsible sidebar (icons only): 64px
- Main content: full width with p-6

#### Mobile (<768px)
- No sidebar (drawer instead)
- Bottom navigation or hamburger menu
- Full width with p-4

### RTL Considerations
- Use `dir="rtl"` on root
- Use logical properties: `mr-*` → `me-*`, `ml-*` → `ms-*`
- Flip icons where needed (arrows, chevrons)
- Text alignment follows natural direction

### Accessibility
- Focus rings: `focus-visible:ring-2 focus-visible:ring-blue-500`
- Color contrast: WCAG AA minimum
- Touch targets: 44x44px minimum
- Reduced motion: `motion-reduce:transition-none`

## When to Use This Skill
- Creating new components
- Styling existing components
- Building page layouts
- Implementing responsive design
- Ensuring accessibility
- Maintaining design consistency
