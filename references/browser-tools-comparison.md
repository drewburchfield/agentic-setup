# Browser Tools: Command-by-Command Comparison

Four browser automation tools, each with different strengths. This matrix covers every capability across all four.

## Quick Reference

| Tool | Type | Auth Sessions | Total Capabilities | Best For |
|------|------|---------------|-------------------|----------|
| **[agent-browser](https://github.com/vercel-labs/agent-browser)** | CLI (Rust + Playwright) | Via saved state | ~130 | Full-featured automation, video, network mocking, stealth |
| **[dev-browser](https://github.com/sawyerhood/dev-browser)** | Claude Code plugin | Via Chrome extension | ~79 | Fast automation with existing Chrome logins |
| **[Claude-in-Chrome](https://claude.ai)** | Chrome extension + MCP | Native (your browser) | ~18 | Authenticated workflows, GIF recording, zero setup |
| **[Playwright MCP](https://playwright.dev/)** | MCP server | Via storage state | ~40 | Cross-browser testing, coordinate-based vision |

### What You Lose

| If you choose only... | You lose... |
|----------------------|-------------|
| **agent-browser** | Existing Chrome logins (without state save), native auth sessions |
| **dev-browser** | Video recording, network mocking, semantic locators, stealth, security features |
| **Claude-in-Chrome** | Programmatic control, headless mode, network interception, semantic locators, fine-grained waits |
| **Playwright MCP** | Video recording, network mocking, semantic locators, session management, keyboard combos |

---

## Complete Command Matrix

### Navigation

| Capability | agent-browser | dev-browser | Claude-in-Chrome | Playwright MCP |
|------------|---------------|-------------|-----------------|----------------|
| Go to URL | `open <url>` | `page.goto(url)` | `navigate` | `browser_navigate` |
| Go back | `back` | `page.goBack()` | `navigate` (back) | `browser_navigate_back` |
| Go forward | `forward` | `page.goForward()` | `navigate` (forward) | ❌ |
| Reload | `reload` | `page.reload()` | `navigate` (reload) | ❌ |
| Close browser | `close` | `client.close()` | ❌ | `browser_close` |
| Connect to existing | `connect <port>` | Extension mode | Native (extension) | ❌ |
| **Count** | **6** | **5** | **4** | **2** |

### Page Reading

| Capability | agent-browser | dev-browser | Claude-in-Chrome | Playwright MCP |
|------------|---------------|-------------|-----------------|----------------|
| Full accessibility tree | `snapshot` | `getAISnapshot()` | `read_page` | `browser_snapshot` |
| Interactive elements only | `snapshot -i` | ❌ | ❌ | ❌ |
| Compact output | `snapshot -c` | ❌ | ❌ | ❌ |
| Limit depth | `snapshot -d <n>` | ❌ | ❌ | ❌ |
| Scope to selector | `snapshot -s ".foo"` | ❌ | ❌ | ❌ |
| Annotated screenshot | `screenshot --annotate` | ❌ | ❌ | ❌ |
| Plain text extraction | `get text` | `page.textContent()` | `get_page_text` | via snapshot |
| Natural language find | ❌ | ❌ | `find` | ❌ |
| **Count** | **7** | **2** | **3** | **1** |

### Element Interaction

| Capability | agent-browser | dev-browser | Claude-in-Chrome | Playwright MCP |
|------------|---------------|-------------|-----------------|----------------|
| Click | `click @ref` | `page.click()` | `computer` (click) | `browser_click` |
| Double-click | `dblclick @ref` | `page.dblclick()` | `computer` (dblclick) | `browser_click` (option) |
| Right-click | `click @ref --button right` | `page.click({button:'right'})` | ❌ | `browser_click` (option) |
| Focus | `focus @ref` | `page.focus()` | ❌ | ❌ |
| Fill (clear + type) | `fill @ref "text"` | `page.fill()` | `form_input` | `browser_fill_form` |
| Type (no clear) | `type @ref "text"` | `page.type()` | `computer` (type) | `browser_type` |
| Hover | `hover @ref` | `page.hover()` | ❌ | `browser_hover` |
| Check checkbox | `check @ref` | `page.check()` | `form_input` | ❌ |
| Uncheck checkbox | `uncheck @ref` | `page.uncheck()` | `form_input` | ❌ |
| Select dropdown | `select @ref "val"` | `page.selectOption()` | `form_input` | `browser_select_option` |
| Multi-select | `select @ref "a" "b"` | `page.selectOption([])` | ❌ | ❌ |
| Drag and drop | `drag @ref1 @ref2` | `page.dragAndDrop()` | ❌ | `browser_drag` |
| File upload | `upload @ref <file>` | `page.setInputFiles()` | `upload_image` | `browser_file_upload` |
| File download | `download` | ❌ | ❌ | ❌ |
| Scroll page | `scroll down 500` | `page.mouse.wheel()` | `computer` (scroll) | ❌ |
| Scroll to element | `scrollintoview @ref` | `locator.scrollIntoViewIfNeeded()` | ❌ | ❌ |
| **Count** | **16** | **13** | **8** | **8** |

### Keyboard Control

| Capability | agent-browser | dev-browser | Claude-in-Chrome | Playwright MCP |
|------------|---------------|-------------|-----------------|----------------|
| Press key | `press Enter` | `page.keyboard.press()` | `computer` (key) | `browser_press_key` |
| Key combination | `press Control+a` | `page.keyboard.press()` | ❌ | ❌ |
| Hold key down | `keydown Shift` | `page.keyboard.down()` | ❌ | ❌ |
| Release key | `keyup Shift` | `page.keyboard.up()` | ❌ | ❌ |
| Raw keyboard type | `keyboard type "text"` | ❌ | ❌ | ❌ |
| Insert text (no events) | `keyboard inserttext "text"` | ❌ | ❌ | ❌ |
| **Count** | **6** | **4** | **1** | **1** |

### Mouse Control

| Capability | agent-browser | dev-browser | Claude-in-Chrome | Playwright MCP |
|------------|---------------|-------------|-----------------|----------------|
| Move to position | `mouse move 100 200` | `page.mouse.move()` | `computer` (move) | `browser_mouse_move_xy` * |
| Click at position | ❌ | `page.mouse.click()` | `computer` (click xy) | `browser_mouse_click_xy` * |
| Mouse button down | `mouse down left` | `page.mouse.down()` | ❌ | `browser_mouse_down` * |
| Mouse button up | `mouse up left` | `page.mouse.up()` | ❌ | `browser_mouse_up` * |
| Mouse wheel | `mouse wheel 100` | `page.mouse.wheel()` | ❌ | `browser_mouse_wheel` * |
| Drag by coordinates | ❌ | ❌ | ❌ | `browser_mouse_drag_xy` * |
| **Count** | **4** | **5** | **2** | **6** * |

*\* Requires `--caps=vision` flag*

### Semantic Locators (Find by Meaning)

| Capability | agent-browser | dev-browser | Claude-in-Chrome | Playwright MCP |
|------------|---------------|-------------|-----------------|----------------|
| Find by ARIA role | `find role button click --name "Submit"` | `page.getByRole()` | ❌ | ❌ |
| Find by visible text | `find text "Login" click` | `page.getByText()` | ❌ | ❌ |
| Find by label | `find label "Email" fill "a@b.com"` | `page.getByLabel()` | ❌ | ❌ |
| Find by placeholder | `find placeholder "Search..." type "query"` | `page.getByPlaceholder()` | ❌ | ❌ |
| Find by alt text | `find alt "Logo" click` | `page.getByAltText()` | ❌ | ❌ |
| Find by title | `find title "Close" click` | `page.getByTitle()` | ❌ | ❌ |
| Find by test ID | `find testid "submit-btn" click` | `page.getByTestId()` | ❌ | ❌ |
| Find first/last/nth | `find first ".item" click` | `locator.first()` | ❌ | ❌ |
| Find by natural language | ❌ | ❌ | `find` | ❌ |
| **Count** | **8** | **8** | **1** | **0** |

### Data Extraction

| Capability | agent-browser | dev-browser | Claude-in-Chrome | Playwright MCP |
|------------|---------------|-------------|-----------------|----------------|
| Get element text | `get text @ref` | `page.textContent()` | `get_page_text` | via snapshot |
| Get innerHTML | `get html @ref` | `page.innerHTML()` | ❌ | ❌ |
| Get input value | `get value @ref` | `page.inputValue()` | ❌ | ❌ |
| Get attribute | `get attr @ref href` | `page.getAttribute()` | ❌ | ❌ |
| Get page title | `get title` | `page.title()` | via `read_page` | via snapshot |
| Get current URL | `get url` | `page.url()` | via `read_page` | via snapshot |
| Count elements | `get count ".items"` | `locator.count()` | ❌ | ❌ |
| Get bounding box | `get box @ref` | `locator.boundingBox()` | ❌ | ❌ |
| Get computed styles | `get styles @ref` | `page.evaluate()` | ❌ | ❌ |
| **Count** | **9** | **8** | **2** | **0** (via snapshot) |

### State Checking

| Capability | agent-browser | dev-browser | Claude-in-Chrome | Playwright MCP |
|------------|---------------|-------------|-----------------|----------------|
| Is visible | `is visible @ref` | `locator.isVisible()` | ❌ | `browser_verify_element_visible` * |
| Is enabled | `is enabled @ref` | `locator.isEnabled()` | ❌ | ❌ |
| Is checked | `is checked @ref` | `locator.isChecked()` | ❌ | ❌ |
| Verify text visible | ❌ | ❌ | ❌ | `browser_verify_text_visible` * |
| Verify value | ❌ | ❌ | ❌ | `browser_verify_value` * |
| **Count** | **3** | **3** | **0** | **3** * |

*\* Requires `--caps=testing` flag*

### Waiting

| Capability | agent-browser | dev-browser | Claude-in-Chrome | Playwright MCP |
|------------|---------------|-------------|-----------------|----------------|
| Wait for element | `wait @ref` | `page.waitForSelector()` | ❌ | `browser_wait_for` |
| Wait milliseconds | `wait 2000` | `page.waitForTimeout()` | ❌ | `browser_wait_for` |
| Wait for text | `wait --text "Success"` | `page.waitForSelector(':text()')` | ❌ | `browser_wait_for` |
| Wait for URL | `wait --url "**/dashboard"` | `page.waitForURL()` | ❌ | ❌ |
| Wait for network idle | `wait --load networkidle` | `waitForPageLoad()` | ❌ | ❌ |
| Wait for JS condition | `wait --fn "window.ready"` | `page.waitForFunction()` | ❌ | ❌ |
| **Count** | **6** | **5** | **0** | **1** |

### Screenshots & Visual

| Capability | agent-browser | dev-browser | Claude-in-Chrome | Playwright MCP |
|------------|---------------|-------------|-----------------|----------------|
| Screenshot | `screenshot` | `page.screenshot()` | `computer` (screenshot) | `browser_take_screenshot` |
| Full page screenshot | `screenshot --full` | `page.screenshot({fullPage:true})` | ❌ | `browser_take_screenshot` (option) |
| Screenshot to file | `screenshot out.png` | `page.screenshot({path:...})` | ❌ | `browser_take_screenshot` |
| Annotated screenshot | `screenshot --annotate` | ❌ | ❌ | ❌ |
| PDF export | `pdf <path>` | `page.pdf()` | ❌ | `browser_pdf_save` * |
| GIF recording | ❌ | ❌ | `gif_creator` | ❌ |
| Highlight element | `highlight @ref` | ❌ | ❌ | ❌ |
| **Count** | **6** | **3** | **2** | **3** |

*\* Requires `--caps=pdf` flag*

### Video & Tracing

| Capability | agent-browser | dev-browser | Claude-in-Chrome | Playwright MCP |
|------------|---------------|-------------|-----------------|----------------|
| Start video recording | `record start vid.webm` | ❌ | ❌ | `--save-video` (config) |
| Stop video recording | `record stop` | ❌ | ❌ | auto |
| GIF recording | ❌ | ❌ | `gif_creator` | ❌ |
| Start trace | `trace start` | ❌ | ❌ | `browser_start_tracing` * |
| Stop trace | `trace stop out.zip` | ❌ | ❌ | `browser_stop_tracing` * |
| Start profiler | `profiler start` | ❌ | ❌ | ❌ |
| Stop profiler | `profiler stop [path]` | ❌ | ❌ | ❌ |
| **Count** | **6** | **0** | **1** | **2** * |

*\* Requires `--caps=tracing` flag*

### Network Interception

| Capability | agent-browser | dev-browser | Claude-in-Chrome | Playwright MCP |
|------------|---------------|-------------|-----------------|----------------|
| Route/intercept requests | `network route "**/api/*"` | `page.route()` | ❌ | ❌ |
| Block requests | `network route "**/ads/*" --abort` | `page.route()` | ❌ | `--blocked-origins` (config) |
| Mock response | `network route "/api" --body '{}'` | `page.route()` | ❌ | ❌ |
| Remove routes | `network unroute` | `page.unroute()` | ❌ | ❌ |
| View tracked requests | `network requests` | ❌ | `read_network_requests` | `browser_network_requests` |
| Filter requests | `network requests --filter api` | ❌ | pattern filter | ❌ |
| **Count** | **6** | **2** | **2** | **1** |

### Cookies & Storage

| Capability | agent-browser | dev-browser | Claude-in-Chrome | Playwright MCP |
|------------|---------------|-------------|-----------------|----------------|
| Get all cookies | `cookies` | `context.cookies()` | ❌ | ❌ |
| Set cookie | `cookies set name value` | `context.addCookies()` | ❌ | ❌ |
| Clear cookies | `cookies clear` | `context.clearCookies()` | ❌ | ❌ |
| Get localStorage | `storage local` | `page.evaluate()` | ❌ | ❌ |
| Set localStorage | `storage local set key val` | `page.evaluate()` | ❌ | ❌ |
| Clear localStorage | `storage local clear` | `page.evaluate()` | ❌ | ❌ |
| **Count** | **6** | **3** (via evaluate) | **0** | **0** |

### Session & State Management

| Capability | agent-browser | dev-browser | Claude-in-Chrome | Playwright MCP |
|------------|---------------|-------------|-----------------|----------------|
| Save session state | `state save auth.json` | persistent context | Native (browser) | `--storage-state` (config) |
| Load session state | `state load auth.json` | persistent context | Native (browser) | `--storage-state` (config) |
| Named sessions | `--session checkout` | `client.page("name")` | ❌ | ❌ |
| List sessions | `session list` | `client.list()` | ❌ | ❌ |
| Isolated session | `--session new` | default | ❌ | `--isolated` |
| Encrypted state | `AGENT_BROWSER_ENCRYPTION_KEY` | ❌ | ❌ | ❌ |
| **Count** | **6** | **3** | **1** | **2** |

### Tabs & Windows

| Capability | agent-browser | dev-browser | Claude-in-Chrome | Playwright MCP |
|------------|---------------|-------------|-----------------|----------------|
| List tabs | `tab` | ❌ | `tabs_context_mcp` | `browser_tabs` |
| New tab | `tab new [url]` | `context.newPage()` | `tabs_create_mcp` | `browser_tabs` (option) |
| Switch tab | `tab 2` | ❌ | `tabs_context_mcp` | `browser_tabs` (option) |
| Close tab | `tab close` | `page.close()` | ❌ | `browser_tabs` (option) |
| New window | `window new` | `browser.newContext()` | ❌ | ❌ |
| Switch browser | ❌ | ❌ | `switch_browser` | ❌ |
| Resize window | `set viewport 1920 1080` | context option | `resize_window` | `browser_resize` |
| **Count** | **6** | **3** | **4** | **3** |

### Frames (iframes)

| Capability | agent-browser | dev-browser | Claude-in-Chrome | Playwright MCP |
|------------|---------------|-------------|-----------------|----------------|
| Switch to frame | `frame ".iframe"` | `page.frameLocator()` | ❌ | via snapshot |
| Back to main | `frame main` | parent frame | ❌ | via snapshot |
| **Count** | **2** | **1** | **0** | **0** |

### Dialogs (alerts, confirms, prompts)

| Capability | agent-browser | dev-browser | Claude-in-Chrome | Playwright MCP |
|------------|---------------|-------------|-----------------|----------------|
| Accept dialog | `dialog accept [text]` | `page.on('dialog')` | ❌ | `browser_handle_dialog` |
| Dismiss dialog | `dialog dismiss` | `page.on('dialog')` | ❌ | `browser_handle_dialog` |
| **Count** | **2** | **1** | **0** | **1** |

### JavaScript Execution

| Capability | agent-browser | dev-browser | Claude-in-Chrome | Playwright MCP |
|------------|---------------|-------------|-----------------|----------------|
| Run JS | `eval "document.title"` | `page.evaluate()` | `javascript_tool` | `browser_evaluate` |
| Run Playwright code | ❌ | native | ❌ | `browser_run_code` |
| Read console | `console` | `page.on('console')` | `read_console_messages` | `browser_console_messages` |
| Clear console | `console --clear` | ❌ | ❌ | ❌ |
| View errors | `errors` | `page.on('pageerror')` | via console (pattern) | `browser_console_messages` |
| Clear errors | `errors --clear` | ❌ | ❌ | ❌ |
| **Count** | **6** | **3** | **3** | **3** |

### Diffing & Comparison

| Capability | agent-browser | dev-browser | Claude-in-Chrome | Playwright MCP |
|------------|---------------|-------------|-----------------|----------------|
| Diff snapshots | `diff snapshot --baseline` | ❌ | ❌ | ❌ |
| Diff screenshots | `diff screenshot --baseline` | ❌ | ❌ | ❌ |
| Diff URLs | `diff url <url1> <url2>` | ❌ | ❌ | ❌ |
| **Count** | **3** | **0** | **0** | **0** |

### Browser Configuration

| Capability | agent-browser | dev-browser | Claude-in-Chrome | Playwright MCP |
|------------|---------------|-------------|-----------------|----------------|
| Set viewport | `set viewport 1920 1080` | context option | `resize_window` | `browser_resize` |
| Device emulation | `set device "iPhone 14"` | context option | ❌ | `--device` |
| Set geolocation | `set geo 40.7 -74.0` | context option | ❌ | `--grant-permissions` |
| Offline mode | `set offline on` | `context.setOffline()` | ❌ | ❌ |
| Custom headers | `set headers '{...}'` | context option | ❌ | ❌ |
| HTTP auth | `set credentials user pass` | context option | ❌ | ❌ |
| Color scheme | `set media dark` | `page.emulateMedia()` | ❌ | ❌ |
| User agent | `--user-agent` | context option | ❌ | `--user-agent` |
| Proxy | `--proxy url` | context option | ❌ | `--proxy-server` |
| Load extension | `--extension path` | extension mode | Native (extension) | ❌ |
| Headed mode | `--headed` | default | Always headed | `--headed` |
| **Count** | **11** | **8** | **2** | **5** |

### Shortcuts & Automation

| Capability | agent-browser | dev-browser | Claude-in-Chrome | Playwright MCP |
|------------|---------------|-------------|-----------------|----------------|
| Custom shortcuts | ❌ | ❌ | `shortcuts_list` | ❌ |
| Execute shortcut | ❌ | ❌ | `shortcuts_execute` | ❌ |
| Action plan/preview | ❌ | ❌ | `update_plan` | ❌ |
| **Count** | **0** | **0** | **3** | **0** |

---

## Summary Totals

| Category | agent-browser | dev-browser | Claude-in-Chrome | Playwright MCP |
|----------|---------------|-------------|-----------------|----------------|
| Navigation | 6 | 5 | 4 | 2 |
| Page Reading | 7 | 2 | 3 | 1 |
| Element Interaction | 16 | 13 | 8 | 8 |
| Keyboard | 6 | 4 | 1 | 1 |
| Mouse | 4 | 5 | 2 | 6* |
| Semantic Locators | 8 | 8 | 1 | 0 |
| Data Extraction | 9 | 8 | 2 | 0 |
| State Checking | 3 | 3 | 0 | 3* |
| Waiting | 6 | 5 | 0 | 1 |
| Screenshots & Visual | 6 | 3 | 2 | 3 |
| Video/Tracing | 6 | 0 | 1 | 2* |
| Network | 6 | 2 | 2 | 1 |
| Cookies/Storage | 6 | 3 | 0 | 0 |
| Session Management | 6 | 3 | 1 | 2 |
| Tabs/Windows | 6 | 3 | 4 | 3 |
| Frames | 2 | 1 | 0 | 0 |
| Dialogs | 2 | 1 | 0 | 1 |
| JavaScript & Debug | 6 | 3 | 3 | 3 |
| Diffing | 3 | 0 | 0 | 0 |
| Browser Config | 11 | 8 | 2 | 5 |
| Shortcuts | 0 | 0 | 3 | 0 |
| **TOTAL** | **~130** | **~79** | **~39** | **~42** |

*\* With capability flags enabled*

---

## Capability Gaps Summary

### Only in agent-browser
- Video recording (webm)
- Network mocking (fake API responses)
- Compact/filtered/annotated snapshots
- Session list management with encrypted state
- Console/error clearing
- Offline mode toggle
- HTTP basic auth
- Color scheme emulation
- Chrome DevTools profiling
- Snapshot/screenshot/URL diffing
- Raw keyboard input (no selector)
- File downloads
- Cloud provider integrations (Kernel, Browserbase, Browser Use)
- iOS device support (via Appium)

### Only in dev-browser
- Chrome extension mode (use existing logged-in browser)
- Page persistence across script disconnections
- Direct full Playwright API access

### Only in Claude-in-Chrome
- Native authenticated sessions (your actual browser, no state export needed)
- GIF recording of interactions
- Natural language element finding
- Custom shortcuts system
- Action plan/preview before execution
- Zero-config setup (`/chrome` slash command)
- Built-in safety (blocks financial transactions, pauses for CAPTCHAs)

### Only in Playwright MCP
- Coordinate-based mouse (vision mode)
- Testing assertions (verify visible, verify value)
- Multi-browser (Firefox, WebKit, Edge)
- Browser auto-installation

---

## Bot Aversion & Stealth

For sites with bot detection, agent-browser provides several options:

| Approach | How |
|----------|-----|
| **Kernel cloud** | `-p kernel` with `KERNEL_STEALTH=1` for managed stealth mode |
| **Custom user-agent** | `--user-agent <ua>` to spoof browser identity |
| **Device emulation** | `set device "iPhone 14"` for mobile fingerprint |
| **Proxy** | `--proxy <url>` with `--proxy-bypass` |
| **Chrome extensions** | `--extension <path>` to load anti-detect extensions |
| **Persistent profiles** | `--profile <path>` for realistic browsing history |
| **Custom headers** | `set headers '{...}'` for additional spoofing |

Claude-in-Chrome is inherently stealth since it controls your real browser with real cookies, extensions, and fingerprint. No bot detection to trigger.

---

## Security Features (agent-browser v0.15+)

| Feature | Description |
|---------|-------------|
| **Auth vault** | AES-256 encrypted credential storage, reference by name |
| **Domain allowlist** | `--allowed-domains` restricts navigation |
| **Action policy** | `--action-policy <file>` gates destructive actions |
| **Action confirmation** | `--confirm-actions` requires approval for sensitive categories |
| **Content boundaries** | `--content-boundaries` wraps output for LLM safety |
| **Output limits** | `--max-output` prevents context flooding |
| **Encrypted state** | `AGENT_BROWSER_ENCRYPTION_KEY` for AES-256-GCM session encryption |

---

## Decision Framework

```
Do you need to use existing Chrome logins?
├─ YES, and minimal setup preferred → Claude-in-Chrome
├─ YES, and need programmatic control → dev-browser (extension mode)
└─ NO
   └─ Do you need video recording or network mocking?
      ├─ YES → agent-browser
      └─ NO
         └─ Do you need to avoid bot detection?
            ├─ YES → agent-browser (Kernel stealth or extensions)
            │        OR Claude-in-Chrome (real browser, no detection)
            └─ NO
               └─ Do you need multi-browser testing?
                  ├─ YES → Playwright MCP
                  └─ NO
                     └─ Do you need GIF recording of workflows?
                        ├─ YES → Claude-in-Chrome
                        └─ NO
                           └─ Do you prioritize speed?
                              ├─ YES → dev-browser (fastest)
                              └─ NO → agent-browser (most features)
```

---

## Setup

| Tool | Install | Config |
|------|---------|--------|
| **agent-browser** | `npm install -g agent-browser` or `brew install agent-browser` | CLI flags or `agent-browser.json` |
| **dev-browser** | Claude Code plugin (dev-browser marketplace) | Plugin settings |
| **Claude-in-Chrome** | `/chrome` slash command in Claude Code | Chrome extension settings |
| **Playwright MCP** | `npx @playwright/mcp@latest` | MCP server config per harness |
