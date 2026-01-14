# QA & Testing Skill

## Purpose
Systematic testing approach for Tami - covering transcription, search, entities, and UI functionality.

## Test Categories

### 1. Transcription Tests

#### Audio Upload Tests
| Test Case | Input | Expected Result |
|-----------|-------|-----------------|
| Valid MP3 | 1-5 min MP3 | Upload success, processing starts |
| Valid M4A | iPhone recording | Upload success, processing starts |
| Valid WAV | Large WAV file | Upload success, processing starts |
| Valid WebM | Browser recording | Upload success, processing starts |
| Invalid format | .txt file | Error: "פורמט לא נתמך" |
| Too large | >100MB file | Error: "הקובץ גדול מדי" |
| Empty file | 0 bytes | Error: appropriate message |
| Corrupted audio | Damaged file | Graceful error handling |

#### Transcription Quality Tests
| Test Case | Audio Type | Check For |
|-----------|------------|-----------|
| Hebrew only | Clear Hebrew | Accurate transcription, proper spelling |
| Hebrew slang | Informal Hebrew | Slang recognized |
| Hebrew + English | Mixed | Both languages transcribed |
| Multiple speakers | 2-3 people | Speaker separation |
| Background noise | Noisy room | Best-effort transcription |
| Long recording | 30+ minutes | Completion without timeout |

#### Provider Tests
| Provider | Test | Expected |
|----------|------|----------|
| Whisper | Hebrew audio | Transcription completes |
| Ivrit | Hebrew audio | Better Hebrew accuracy (when working) |
| Fallback | Ivrit fails | Automatic fallback to Whisper |
| Auto-detect | Hebrew audio | Routes to Ivrit |
| Auto-detect | English audio | Routes to Whisper |

### 2. Search Tests

#### Global Search
| Query | Expected Results |
|-------|-----------------|
| Person name | Sessions mentioning that person |
| Project name | Sessions about that project |
| Hebrew phrase | Matching transcript segments |
| Partial word | Prefix matching works |
| Empty query | No results / all sessions |
| Special chars | Escaped properly, no errors |

#### Per-Session Search
| Test Case | Expected |
|-----------|----------|
| Word in transcript | Highlighted matches |
| Multiple matches | All instances highlighted |
| No matches | "לא נמצאו תוצאות" message |
| Case insensitive | Matches regardless of case |

#### Search Suggestions
| Input | Expected |
|-------|----------|
| Type 2+ chars | Suggestions appear |
| Select suggestion | Search executed |
| Arrow keys | Navigate suggestions |
| Escape | Close suggestions |

### 3. Entity Tests

#### Entity Extraction
| Entity Type | Test Input | Expected |
|-------------|------------|----------|
| Person | "דברתי עם יוסי" | יוסי extracted |
| Organization | "פגישה עם גוגל" | גוגל extracted |
| Project | "פרויקט אלפא" | אלפא extracted |
| Date | "ב-15 לינואר" | Date extracted |
| Time | "בשעה 3" | Time extracted |
| Price | "100 שקל" | Price extracted |
| Location | "במשרד בתל אביב" | Location extracted |

#### Entity Display
| Test | Expected |
|------|----------|
| Session entities tab | All entities listed by type |
| Entity in transcript | Highlighted with color |
| Entity click | Shows all mentions |
| Entities page | Grid of all entities |

### 4. Tag Tests

#### Tag Management
| Action | Expected |
|--------|----------|
| Create tag | New tag appears in list |
| Edit tag name | Name updated |
| Change tag color | Color updated |
| Delete tag | Tag removed, sessions updated |
| Hide auto-tag | Tag hidden from lists |

#### Session Tagging
| Action | Expected |
|--------|----------|
| Add tag to session | Tag pill appears |
| Remove tag | Tag removed |
| Filter by tag | Only tagged sessions shown |
| Multiple tags | All tags displayed |

### 5. UI/UX Tests

#### Responsive Design
| Breakpoint | Expected |
|------------|----------|
| Desktop (>1024px) | Full sidebar visible |
| Tablet (768-1023px) | Collapsed sidebar (icons) |
| Mobile (<768px) | Drawer navigation |

#### RTL Layout
| Element | Check |
|---------|-------|
| Text alignment | Right-aligned |
| Sidebar position | Right side |
| Icons | Arrows/chevrons flipped |
| Form inputs | Cursor starts right |

#### Keyboard Navigation
| Shortcut | Action |
|----------|--------|
| Cmd/Ctrl+K | Open global search |
| Escape | Close modals/search |
| Tab | Focus next element |
| Enter | Activate button |

### 6. Audio Player Tests

| Feature | Test |
|---------|------|
| Play/Pause | Toggles playback |
| Speed control | 0.5x, 1x, 1.5x, 2x work |
| Seek bar | Jump to position |
| Time display | Current/total time shown |
| Volume | Adjustable |

### 7. Session Lifecycle Tests

| Stage | Test |
|-------|------|
| Create (upload) | Session created, status "pending" |
| Processing | Status updates to "processing" |
| Transcription | Transcript appears |
| Summary | Summary generated |
| Action items | Items extractable |
| Edit title | Title updates |
| Delete | Session removed |

### 8. Error Handling Tests

| Scenario | Expected |
|----------|----------|
| Network failure | Toast with retry option |
| Server error (500) | User-friendly error message |
| Timeout | Clear timeout message |
| Auth expired | Redirect to login |
| Rate limit | "נסה שוב מאוחר יותר" |

## Test Scripts

### Quick Smoke Test
```
1. Navigate to /conversations
2. Click "שיחה חדשה"
3. Upload test audio file
4. Wait for processing (check status badge)
5. Open session, verify transcript
6. Check summary tab
7. Add action item
8. Use chat to ask question
9. Search for term in transcript
10. Delete session
```

### Full Regression Test
```
1. Authentication
   - Login with email
   - Login with Google
   - Logout
   - Session persistence

2. Session Management
   - Create via upload
   - Create via recording
   - Edit title
   - Delete session
   - Status transitions

3. Transcription
   - Whisper provider
   - Ivrit provider (if configured)
   - Speaker detection
   - Speaker name editing

4. AI Features
   - Summary generation
   - Action item extraction
   - Chat Q&A

5. Search & Discovery
   - Global search
   - Per-session search
   - Entity browsing
   - Tag filtering

6. UI Verification
   - Desktop layout
   - Tablet layout
   - Mobile layout
   - RTL correctness
```

## Test Data

### Sample Audio Files
```
Location: /path/to/test-files/
- hebrew-2min.m4a (clear Hebrew, 2 speakers)
- hebrew-long.mp3 (30 min meeting)
- mixed-lang.wav (Hebrew + English)
- noisy-room.webm (background noise)
- single-speaker.m4a (monologue)
```

### Expected Entities (for hebrew-2min.m4a)
```
Persons: יוסי, מיכל
Organizations: גוגל
Projects: פרויקט אלפא
Dates: 15 לינואר
Prices: 100 שקל
```

## Bug Report Template

```markdown
## Bug Description
[Brief description]

## Steps to Reproduce
1.
2.
3.

## Expected Behavior
[What should happen]

## Actual Behavior
[What actually happens]

## Environment
- Browser:
- OS:
- Screen size:
- User: dev / prod

## Screenshots/Logs
[Attach if available]

## Severity
- [ ] Critical (app unusable)
- [ ] High (major feature broken)
- [ ] Medium (workaround exists)
- [ ] Low (cosmetic/minor)
```

## When to Use This Skill
- Writing test cases
- Running regression tests
- Verifying bug fixes
- Testing new features
- Quality assurance before release
