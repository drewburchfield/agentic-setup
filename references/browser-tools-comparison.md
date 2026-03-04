# Browser Tools: Command-by-Command Comparison

## Quick Reference: What You Lose

| If you choose... | You lose... |
|------------------|-------------|
| **dev-browser only** | Video recording, network mocking, semantic locators, CLI convenience, session management |
| **agent-browser only** | Chrome extension mode (existing auth), coordinate-based vision, PDF export, testing assertions |
| **Playwright MCP only** | Video recording, network mocking, semantic locators, session management, keyboard combos |

---

## Complete Command Matrix

### Navigation

| Capability | agent-browser | dev-browser | Playwright MCP |
|------------|---------------|-------------|----------------|
| Go to URL | `open <url>` | `page.goto(url)` | `browser_navigate` |
| Go back | `back` | `page.goBack()` | `browser_navigate_back` |
| Go forward | `forward` | `page.goForward()` | ❌ |
| Reload | `reload` | `page.reload()` | ❌ |
| Close browser | `close` | `client.close()` | `browser_close` |
| Connect to existing | `connect <port>` | Extension mode | ❌ |
| **Count** | **6** | **5** | **2** |

### Page Snapshots

| Capability | agent-browser | dev-browser | Playwright MCP |
|------------|---------------|-------------|----------------|
| Full accessibility tree | `snapshot` | `getAISnapshot()` | `browser_snapshot` |
| Interactive elements only | `snapshot -i` | ❌ | ❌ |
| Compact output | `snapshot -c` | ❌ | ❌ |
| Limit depth | `snapshot -d <n>` | ❌ | ❌ |
| Scope to selector | `snapshot -s ".foo"` | ❌ | ❌ |
| **Count** | **5** | **1** | **1** |

### Element Interaction

| Capability | agent-browser | dev-browser | Playwright MCP |
|------------|---------------|-------------|----------------|
| Click | `click @ref` | `page.click()` | `browser_click` |
| Double-click | `dblclick @ref` | `page.dblclick()` | `browser_click` (option) |
| Right-click | `click @ref --button right` | `page.click({button:'right'})` | `browser_click` (option) |
| Focus | `focus @ref` | `page.focus()` | ❌ |
| Fill (clear + type) | `fill @ref "text"` | `page.fill()` | `browser_fill_form` |
| Type (no clear) | `type @ref "text"` | `page.type()` | `browser_type` |
| Hover | `hover @ref` | `page.hover()` | `browser_hover` |
| Check checkbox | `check @ref` | `page.check()` | ❌ |
| Uncheck checkbox | `uncheck @ref` | `page.uncheck()` | ❌ |
| Select dropdown | `select @ref "val"` | `page.selectOption()` | `browser_select_option` |
| Multi-select | `select @ref "a" "b"` | `page.selectOption([])` | ❌ |
| Drag and drop | `drag @ref1 @ref2` | `page.dragAndDrop()` | `browser_drag` |
| File upload | `upload @ref <file>` | `page.setInputFiles()` | `browser_file_upload` |
| Scroll page | `scroll down 500` | `page.mouse.wheel()` | ❌ |
| Scroll to element | `scrollintoview @ref` | `locator.scrollIntoViewIfNeeded()` | ❌ |
| **Count** | **15** | **13** | **8** |

### Keyboard Control

| Capability | agent-browser | dev-browser | Playwright MCP |
|------------|---------------|-------------|----------------|
| Press key | `press Enter` | `page.keyboard.press()` | `browser_press_key` |
| Key combination | `press Control+a` | `page.keyboard.press()` | ❌ |
| Hold key down | `keydown Shift` | `page.keyboard.down()` | ❌ |
| Release key | `keyup Shift` | `page.keyboard.up()` | ❌ |
| **Count** | **4** | **4** | **1** |

### Mouse Control

| Capability | agent-browser | dev-browser | Playwright MCP |
|------------|---------------|-------------|----------------|
| Move to position | `mouse move 100 200` | `page.mouse.move()` | `browser_mouse_move_xy` * |
| Click at position | ❌ | `page.mouse.click()` | `browser_mouse_click_xy` * |
| Mouse button down | `mouse down left` | `page.mouse.down()` | `browser_mouse_down` * |
| Mouse button up | `mouse up left` | `page.mouse.up()` | `browser_mouse_up` * |
| Mouse wheel | `mouse wheel 100` | `page.mouse.wheel()` | `browser_mouse_wheel` * |
| Drag by coordinates | ❌ | ❌ | `browser_mouse_drag_xy` * |
| **Count** | **4** | **5** | **6** * |

*\* Requires `--caps=vision` flag*

### Semantic Locators (Find by Meaning)

| Capability | agent-browser | dev-browser | Playwright MCP |
|------------|---------------|-------------|----------------|
| Find by ARIA role | `find role button click --name "Submit"` | `page.getByRole()` | ❌ |
| Find by visible text | `find text "Login" click` | `page.getByText()` | ❌ |
| Find by label | `find label "Email" fill "a@b.com"` | `page.getByLabel()` | ❌ |
| Find by placeholder | `find placeholder "Search..." type "query"` | `page.getByPlaceholder()` | ❌ |
| Find by alt text | `find alt "Logo" click` | `page.getByAltText()` | ❌ |
| Find by title | `find title "Close" click` | `page.getByTitle()` | ❌ |
| Find by test ID | `find testid "submit-btn" click` | `page.getByTestId()` | ❌ |
| Find first/last/nth | `find first ".item" click` | `locator.first()` | ❌ |
| **Count** | **8** | **8** | **0** |

### Data Extraction

| Capability | agent-browser | dev-browser | Playwright MCP |
|------------|---------------|-------------|----------------|
| Get element text | `get text @ref` | `page.textContent()` | via snapshot |
| Get innerHTML | `get html @ref` | `page.innerHTML()` | ❌ |
| Get input value | `get value @ref` | `page.inputValue()` | ❌ |
| Get attribute | `get attr @ref href` | `page.getAttribute()` | ❌ |
| Get page title | `get title` | `page.title()` | via snapshot |
| Get current URL | `get url` | `page.url()` | via snapshot |
| Count elements | `get count ".items"` | `locator.count()` | ❌ |
| Get bounding box | `get box @ref` | `locator.boundingBox()` | ❌ |
| Get computed styles | `get styles @ref` | `page.evaluate()` | ❌ |
| **Count** | **9** | **8** | **0** (via snapshot) |

### State Checking

| Capability | agent-browser | dev-browser | Playwright MCP |
|------------|---------------|-------------|----------------|
| Is visible | `is visible @ref` | `locator.isVisible()` | `browser_verify_element_visible` * |
| Is enabled | `is enabled @ref` | `locator.isEnabled()` | ❌ |
| Is checked | `is checked @ref` | `locator.isChecked()` | ❌ |
| Verify text visible | ❌ | ❌ | `browser_verify_text_visible` * |
| Verify value | ❌ | ❌ | `browser_verify_value` * |
| **Count** | **3** | **3** | **3** * |

*\* Requires `--caps=testing` flag*

### Waiting

| Capability | agent-browser | dev-browser | Playwright MCP |
|------------|---------------|-------------|----------------|
| Wait for element | `wait @ref` | `page.waitForSelector()` | `browser_wait_for` |
| Wait milliseconds | `wait 2000` | `page.waitForTimeout()` | `browser_wait_for` |
| Wait for text | `wait --text "Success"` | `page.waitForSelector(':text()')` | `browser_wait_for` |
| Wait for URL | `wait --url "**/dashboard"` | `page.waitForURL()` | ❌ |
| Wait for network idle | `wait --load networkidle` | `waitForPageLoad()` | ❌ |
| Wait for JS condition | `wait --fn "window.ready"` | `page.waitForFunction()` | ❌ |
| **Count** | **6** | **5** | **1** |

### Screenshots & Visual

| Capability | agent-browser | dev-browser | Playwright MCP |
|------------|---------------|-------------|----------------|
| Screenshot | `screenshot` | `page.screenshot()` | `browser_take_screenshot` |
| Full page screenshot | `screenshot --full` | `page.screenshot({fullPage:true})` | `browser_take_screenshot` (option) |
| Screenshot to file | `screenshot out.png` | `page.screenshot({path:...})` | `browser_take_screenshot` |
| PDF export | ❌ | `page.pdf()` | `browser_pdf_save` * |
| Highlight element | `highlight @ref` | ❌ | ❌ |
| **Count** | **4** | **3** | **3** |

*\* Requires `--caps=pdf` flag*

### Video & Tracing

| Capability | agent-browser | dev-browser | Playwright MCP |
|------------|---------------|-------------|----------------|
| Start video recording | `record start vid.webm` | ❌ | `--save-video` (config) |
| Stop video recording | `record stop` | ❌ | auto |
| Start trace | `trace start` | ❌ | `browser_start_tracing` * |
| Stop trace | `trace stop out.zip` | ❌ | `browser_stop_tracing` * |
| **Count** | **4** | **0** | **2** * |

*\* Requires `--caps=tracing` flag*

### Network Interception

| Capability | agent-browser | dev-browser | Playwright MCP |
|------------|---------------|-------------|----------------|
| Route/intercept requests | `network route "**/api/*"` | `page.route()` | ❌ |
| Block requests | `network route "**/ads/*" --abort` | `page.route()` | `--blocked-origins` (config) |
| Mock response | `network route "/api" --body '{}'` | `page.route()` | ❌ |
| Remove routes | `network unroute` | `page.unroute()` | ❌ |
| View tracked requests | `network requests` | ❌ | `browser_network_requests` |
| Filter requests | `network requests --filter api` | ❌ | ❌ |
| **Count** | **6** | **2** | **1** |

### Cookies & Storage

| Capability | agent-browser | dev-browser | Playwright MCP |
|------------|---------------|-------------|----------------|
| Get all cookies | `cookies` | `context.cookies()` | ❌ |
| Set cookie | `cookies set name value` | `context.addCookies()` | ❌ |
| Clear cookies | `cookies clear` | `context.clearCookies()` | ❌ |
| Get localStorage | `storage local` | `page.evaluate()` | ❌ |
| Set localStorage | `storage local set key val` | `page.evaluate()` | ❌ |
| Clear localStorage | `storage local clear` | `page.evaluate()` | ❌ |
| **Count** | **6** | **3** (via evaluate) | **0** |

### Session & State Management

| Capability | agent-browser | dev-browser | Playwright MCP |
|------------|---------------|-------------|----------------|
| Save session state | `state save auth.json` | persistent context | `--storage-state` (config) |
| Load session state | `state load auth.json` | persistent context | `--storage-state` (config) |
| Named sessions | `--session checkout` | `client.page("name")` | ❌ |
| List sessions | `session list` | `client.list()` | ❌ |
| Isolated session | `--session new` | default | `--isolated` |
| **Count** | **5** | **3** | **2** |

### Tabs & Windows

| Capability | agent-browser | dev-browser | Playwright MCP |
|------------|---------------|-------------|----------------|
| List tabs | `tab` | ❌ | `browser_tabs` |
| New tab | `tab new [url]` | `context.newPage()` | `browser_tabs` (option) |
| Switch tab | `tab 2` | ❌ | `browser_tabs` (option) |
| Close tab | `tab close` | `page.close()` | `browser_tabs` (option) |
| New window | `window new` | `browser.newContext()` | ❌ |
| **Count** | **5** | **2** | **1** |

### Frames (iframes)

| Capability | agent-browser | dev-browser | Playwright MCP |
|------------|---------------|-------------|----------------|
| Switch to frame | `frame ".iframe"` | `page.frameLocator()` | via snapshot |
| Back to main | `frame main` | parent frame | via snapshot |
| **Count** | **2** | **1** | **0** |

### Dialogs (alerts, confirms, prompts)

| Capability | agent-browser | dev-browser | Playwright MCP |
|------------|---------------|-------------|----------------|
| Accept dialog | `dialog accept [text]` | `page.on('dialog')` | `browser_handle_dialog` |
| Dismiss dialog | `dialog dismiss` | `page.on('dialog')` | `browser_handle_dialog` |
| **Count** | **2** | **1** | **1** |

### JavaScript Execution

| Capability | agent-browser | dev-browser | Playwright MCP |
|------------|---------------|-------------|----------------|
| Run JS | `eval "document.title"` | `page.evaluate()` | `browser_evaluate` |
| Run Playwright code | ❌ | native | `browser_run_code` |
| **Count** | **1** | **2** | **2** |

### Browser Configuration

| Capability | agent-browser | dev-browser | Playwright MCP |
|------------|---------------|-------------|----------------|
| Set viewport | `set viewport 1920 1080` | context option | `browser_resize` |
| Device emulation | `set device "iPhone 14"` | context option | `--device` |
| Set geolocation | `set geo 40.7 -74.0` | context option | `--grant-permissions` |
| Offline mode | `set offline on` | `context.setOffline()` | ❌ |
| Custom headers | `set headers '{...}'` | context option | ❌ |
| HTTP auth | `set credentials user pass` | context option | ❌ |
| Color scheme | `set media dark` | `page.emulateMedia()` | ❌ |
| User agent | `--user-agent` | context option | `--user-agent` |
| Proxy | `--proxy url` | context option | `--proxy-server` |
| Load extension | `--extension path` | extension mode | ❌ |
| Headed mode | `--headed` | default | `--headed` |
| **Count** | **11** | **8** | **5** |

### Debugging

| Capability | agent-browser | dev-browser | Playwright MCP |
|------------|---------------|-------------|----------------|
| View console | `console` | `page.on('console')` | `browser_console_messages` |
| Clear console | `console --clear` | ❌ | ❌ |
| View errors | `errors` | `page.on('pageerror')` | `browser_console_messages` |
| Clear errors | `errors --clear` | ❌ | ❌ |
| **Count** | **4** | **2** | **1** |

---

## Summary Totals

| Category | agent-browser | dev-browser | Playwright MCP |
|----------|---------------|-------------|----------------|
| Navigation | 6 | 5 | 2 |
| Snapshots | 5 | 1 | 1 |
| Element Interaction | 15 | 13 | 8 |
| Keyboard | 4 | 4 | 1 |
| Mouse | 4 | 5 | 6* |
| Semantic Locators | 8 | 8 | 0 |
| Data Extraction | 9 | 8 | 0 |
| State Checking | 3 | 3 | 3* |
| Waiting | 6 | 5 | 1 |
| Screenshots | 4 | 3 | 3 |
| Video/Tracing | 4 | 0 | 2* |
| Network | 6 | 2 | 1 |
| Cookies/Storage | 6 | 3 | 0 |
| Session Management | 5 | 3 | 2 |
| Tabs/Windows | 5 | 2 | 1 |
| Frames | 2 | 1 | 0 |
| Dialogs | 2 | 1 | 1 |
| JavaScript | 1 | 2 | 2 |
| Browser Config | 11 | 8 | 5 |
| Debugging | 4 | 2 | 1 |
| **TOTAL** | **~110** | **~79** | **~40** |

*\* With capability flags enabled*

---

## Capability Gaps Summary

### Only in agent-browser
- Video recording (webm)
- Network mocking (fake responses)
- Compact/filtered snapshots
- Session list management
- Console/error clearing
- Offline mode toggle
- HTTP basic auth
- Color scheme emulation

### Only in dev-browser
- Chrome extension mode (use existing logged-in browser)
- Page persistence across script disconnections
- Direct full Playwright API access

### Only in Playwright MCP
- Coordinate-based mouse (vision mode)
- PDF generation
- Testing assertions (verify visible, verify value)
- Multi-browser (Firefox, WebKit, Edge)
- Browser auto-installation

---

## Decision Framework

```
Do you need video recording?
├─ YES → agent-browser
└─ NO
   └─ Do you need to use existing Chrome logins?
      ├─ YES → dev-browser (extension mode)
      └─ NO
         └─ Do you need network mocking/interception?
            ├─ YES → agent-browser
            └─ NO
               └─ Do you need multi-browser testing?
                  ├─ YES → Playwright MCP
                  └─ NO
                     └─ Do you prioritize speed over features?
                        ├─ YES → dev-browser (fastest)
                        └─ NO → agent-browser (most features)
```
