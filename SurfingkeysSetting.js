// ---- Settings ----
api.Hints.setCharacters("asdfgyuiowertnm")
settings.scrollStepSize = 140
settings.hintAlign = 'left'
settings.aceKeybindings = 'emacs'
settings.nextLinkRegex = /((forward|>>|next|次[のへ]|→)+)/i
settings.prevLinkRegex = /((back|<<|prev(ious)?|前[のへ]|←)+)/i
settings.newTabPosition = 'right'
settings.omnibarMaxResults = 12
settings.historyMUOrder = false
settings.smoothScroll = true
settings.scrollStepSize = 560
settings.tabsThreshold = false
settings.stealFocusOnLoad = true
settings.enableAutoFocus = false
settings.showModeStatus = true
settings.cursorAtEndOfInput = false;

// ---- Utils ----
// p押下で一時的にOFF
api.mapkey('p', '#0enter ephemeral PassThrough mode to temporarily suppress SurfingKeys', function() {
  Normal.passThrough(1500);
});

const unmapKeys = (keys) => keys.forEach((key) => api.unmap(key))
const iunmapKeys = (keys) => keys.forEach((key) => api.iunmap(key))
const escapeMap = {
  '&': '&amp;',
  '<': '&lt;',
  '>': '&gt;',
  '"': '&quot;',
  "'": '&#39;',
  '/': '&#x2F;',
  '`': '&#x60;',
  '=': '&#x3D;',
}
const escapeForAlias = (str) =>
  String(str).replace(/[&<>"'`=/]/g, (s) => escapeMap[s])
const createSuggestionItem = (html, props = {}) => {
  const li = document.createElement('li')
  li.innerHTML = html
  return { html: li.outerHTML, props }
}
const padZero = (txt) => `0${txt}`.slice(-2)
const formatDate = (date, format = 'YYYY/MM/DD hh:mm:ss') =>
  format
    .replace('YYYY', date.getFullYear())
    .replace('MM', padZero(date.getMonth() + 1))
    .replace('DD', padZero(date.getDate()))
    .replace('hh', padZero(date.getHours()))
    .replace('mm', padZero(date.getMinutes()))
    .replace('ss', padZero(date.getSeconds()))

const tabOpenBackground = (url) =>
  RUNTIME('openLink', {
    tab: {
      tabbed: true,
      active: false,
    },
    url,
  })

// ---- Maps ----
api.unmap('H')
api.map('H', 'S') // back in history
api.unmap('S')
api.unmap('L')
api.map('L', 'D') // foward in history
api.unmap('D')
api.map('S', 'sg') // 選択したテキストまたはクリップボードからググる
api.unmap('h')
api.map('h', 'E') // previousTab
api.unmap('E')
api.unmap('l')
api.map('l', 'R') // nextTab
api.unmap('R')
api.unmap('F')
api.map('F', 'af') // 別タブで開く
api.unmap('d')
api.map('d', 'x') // タブ閉じる
api.unmap('x')
api.unmap('u')
api.map('u', 'X') // 閉じたタブ復元
api.unmap('X')

api.iunmap(':') // disable emoji
// disable vim binding in insert mode
iunmapKeys([
  '<Ctrl-a>',
  '<Ctrl-e>',
  '<Ctrl-f>',
  '<Ctrl-b>',
  '<Ctrl-k>',
  '<Ctrl-y>',
])
// disable proxy
unmapKeys(['cp', 'spa', 'spb', 'spd', 'spc', 'sps', 'spi', ';cp', ';ap'])

// ---- Search ----
api.removeSearchAlias('b')
api.removeSearchAlias('w')
unmapKeys(['ob', 'sb', 'ow', 'sw'])

// Google 1年以内
api.addSearchAlias('1', 'Google 1年以内', 'https://www.google.co.jp/search?q={0}&tbs=qdr:y');
api.mapkey('o1', '#8Open Search with alias 1', function() {
  Front.openOmnibar({type: "SearchEngine", extra: "1"});
});

// Qiita
api.addSearchAlias('qi', 'Qiita', 'https://qiita.com/search?q=')
api.addSearchAlias('qt', 'Qiita tag', 'https://qiita.com/tags/')

// Twitter
api.addSearchAlias(
  'tw',
  'Twitter',
  'https://twitter.com/search?q=',
  's',
  'https://twitter.com/i/search/typeahead.json?count=10&filters=true&q=',
  (response) =>
    JSON.parse(response.text).topics.api.map((v) =>
      createSuggestionItem(v.topic, {
        url: `https://twitter.com/search?q=${encodeURIComponent(v.topic)}`,
      })
    )
)
api.mapkey('otw', '#8Open Search with alias tw', function () {
  Front.openOmnibar({ type: 'SearchEngine', extra: 'tw' })
})

// Search
api.addSearchAlias('gi', 'github検索', 'https://github.com/search?q={0}&type=code')
api.addSearchAlias('dio', 'DeveloperIO検索', 'https://dev.classmethod.jp/?s={0}')
api.addSearchAlias('zen', 'Zenn検索', 'https://zenn.dev/search?q={0}')
api.addSearchAlias('fa', 'facebook検索', 'https://www.facebook.com/search/top?q={0}')
api.addSearchAlias('gt', 'google翻訳', 'https://www.google.com/search?q=%E7%BF%BB%E8%A8%B3%20{0}')
api.addSearchAlias('t',  'DeepL翻訳', 'https://www.deepl.com/translator#ja/en/{0}')

// Yahoo!リアルタイム検索
api.addSearchAlias(
  'r',
  'Yahoo!リアルタイム検索',
  'https://search.yahoo.co.jp/realtime/search?ei=UTF-8&p='
)
api.mapkey('or', '#8Open Search with alias r', function () {
  Front.openOmnibar({ type: 'SearchEngine', extra: 'r' })
})

// Wikipedia jp
api.addSearchAlias(
  'wi',
  'Wikipedia',
  'https://ja.wikipedia.org/w/index.php?search='
)

// MDN
api.addSearchAlias(
  'md',
  'MDN',
  'https://developer.mozilla.org/ja/search?q=',
  's',
  'https://developer.mozilla.org/api/v1/search/ja?q=',
  (response) => {
    const res = JSON.parse(response.text)
    return res.documents.api.map((s) => {
      let excerpt = escapeForAlias(s.excerpt)
      if (excerpt.length > 240) {
        excerpt = `${excerpt.slice(0, 240)}…`
      }
      res.query.split(' ').forEach((q) => {
        excerpt = excerpt.replace(new RegExp(q, 'gi'), '<strong>$&</strong>')
      })
      const title = escapeForAlias(s.title)
      const slug = escapeForAlias(s.slug)
      return createSuggestionItem(
        `
      <div>
        <div class="title"><strong>${title}</strong></div>
        <div style="font-size:0.8em"><em>${slug}</em></div>
        <div>${excerpt}</div>
      </div>
    `,
        { url: `https://developer.mozilla.org/ja/docs/${s.slug}` }
      )
    })
  }
)

// npm
api.addSearchAlias(
  'np',
  'npm',
  'https://www.npmjs.com/search?q=',
  's',
  'https://api.npms.io/v2/search/suggestions?size=20&q=',
  (response) =>
    JSON.parse(response.text).api.map((s) => {
      let flags = ''
      let desc = ''
      let stars = ''
      let score = ''
      if (s.package.description) {
        desc = escapeForAlias(s.package.description)
      }
      if (s.score && s.score.final) {
        score = Math.round(Number(s.score.final) * 5)
        stars = '⭐'.repeat(score) + '☆'.repeat(5 - score)
      }
      if (s.flags) {
        Object.keys(s.flags).forEach((f) => {
          flags += `[<f4d00'>⚑</span> ${escapeForAlias(
            f
          )}] `
        })
      }
      return createSuggestionItem(
        `
      <div>
        <style>.title>em { font-weight: bold; }</style>
        <div class="title">${s.highlight}</div>
        <div>
          <span style="font-size:1.5em;line-height:1em">${stars}</span>
          <span>${flags}</span>
        </div>
        <div>${desc}</div>
      </div>
    `,
        { url: s.package.links.npm }
      )
    })
)

// Docker Hub
api.addSearchAlias(
  'dh',
  'Docker Hub',
  'https://hub.docker.com/search/?q=',
  's',
  'https://hub.docker.com/v2/search/repositories/?page_size=20&query=',
  (response) =>
    JSON.parse(response.text).results.api.map((s) => {
      let meta = ''
      let repo = s.repo_name
      meta += `[⭐${escapeForAlias(s.star_count)}] `
      meta += `[↓${escapeForAlias(s.pull_count)}] `
      if (repo.indexOf('/') === -1) {
        repo = `_/${repo}`
      }
      return createSuggestionItem(
        `
      <div>
        <div class="title"><strong>${escapeForAlias(repo)}</strong></div>
        <div>${meta}</div>
        <div>${escapeForAlias(s.short_description)}</div>
      </div>
    `,
        { url: `https://hub.docker.com/r/${repo}` }
      )
    })
)

api.mapkey('ok', '#8Open Search with alias k', function () {
  Front.openOmnibar({ type: 'SearchEngine', extra: 'k' })
})

// alc
api.addSearchAlias('al', 'alc', 'https://eow.alc.co.jp/search?q=')
api.mapkey('oa', '#8Open Search with alias al', function () {
  Front.openOmnibar({ type: 'SearchEngine', extra: 'al' })
})
api.unmap("<Ctrl-'>")
api.mapkey("<Ctrl-'>", 'eowf', () => {
  searchSelectedWith('https://eowf.alc.co.jp/search?q=', false, false, '')
})

// ---- Mapkeys ----//
const ri = { repeatIgnore: true }

const Hint = (selector, action = api.Hints.dispatchMouseClick) => () =>
  api.Hints.create(selector, action)
// --- Global mappings ---//
//  0: Help
//  1: Mouse Click
//  2: Scroll Page / Element
//  3: Tabs
//  4: Page Navigation
api.mapkey(
  'gI',
  '#4View image in new tab',
  Hint('img', (i) => tabOpenLink(i.src)),
  ri
)
//  5: Sessions
//  6: Search selected with
//  7: Clipboard
api.mapkey(
  'yI',
  '#7Copy Image URL',
  api.Hint('img', (i) => Clipboard.write(i.src)),
  ri
)

const copyTitleAndUrl = (format) => {
  const text = format
    .replace('%URL%', location.href)
    .replace('%TITLE%', document.title)
  api.Clipboard.write(text)
}
const copyHtmlLink = () => {
  const clipNode = document.createElement('a')
  const range = document.createRange()
  const sel = window.getSelection()
  clipNode.setAttribute('href', location.href)
  clipNode.innerText = document.title
  document.body.appendChild(clipNode)
  range.selectNode(clipNode)
  sel.removeAllRanges()
  sel.addRange(range)
  document.execCommand('copy', false, null)
  document.body.removeChild(clipNode)
  Front.showBanner('Ritch Copied: ' + document.title)
}

api.mapkey('cm', '#7Copy title and link to markdown', () => {
  copyTitleAndUrl('[%TITLE%](%URL%)')
})
api.mapkey('ct', '#7Copy title and link to textile', () => {
  copyTitleAndUrl('"%TITLE%":%URL%')
})
api.mapkey('ch', '#7Copy title and link to human readable', () => {
  copyTitleAndUrl('%TITLE% / %URL%')
})
api.mapkey('cb', '#7Copy title and link to scrapbox', () => {
  copyTitleAndUrl('[%TITLE% %URL%]')
})
api.mapkey('ca', '#7Copy title and link to href', () => {
  copyTitleAndUrl('<a href="%URL%">%TITLE%</a>')
})
api.mapkey('cp', '#7Copy title and link to plantuml', () => {
  copyTitleAndUrl('[[%URL% %TITLE%]]')
})
api.mapkey('cr', '#7Copy rich text link', () => {
  copyHtmlLink()
})
api.mapkey('co', '#7Copy title and link to org', () => {
  copyTitleAndUrl('[[%URL%][%TITLE%]]')
})
api.mapkey('YY', '#7Copy title and link to multi line', () => {
  copyTitleAndUrl('%TITLE%\n%URL%')
})
//  8: Omnibar
//  9: Visual Mode
// 10: vim-like marks
// 11: Settings
// 12: Chrome URLs
api.mapkey('gS', '#12Open Chrome settings', () => tabOpenLink('chrome://settings/'))
// 13: Proxy
// 14: Misc
api.mapkey(';a', '#14Save to Instapaper', () => {
  function iprl5() {
    var d = document,
      z = d.createElement('scr' + 'ipt'),
      b = d.body,
      l = d.location
    try {
      if (!b) throw 0
      d.title = '(Saving...) ' + d.title
      z.setAttribute(
        'src',
        l.protocol +
          '//www.instapaper.com/j/TbVSmwFP6fKy?a=read-later&u=' +
          encodeURIComponent(l.href) +
          '&t=' +
          new Date().getTime()
      )
      b.appendChild(z)
    } catch (e) {
      alert('Please wait until the page has loaded.')
    }
  }
  iprl5()
})
api.mapkey(';t', '#14google translate', () => {
  const selection = window.getSelection().toString()
  if (selection === '') {
    // 文字列選択してない場合はページ自体を翻訳にかける
    tabOpenLink(
      `http://translate.google.com/translate?u=${window.location.href}`
    )
  } else {
    // 選択している場合はそれを翻訳する
    tabOpenLink(
      `https://translate.google.com/?sl=auto&tl=ja&text=${encodeURI(selection)}`
    )
  }
})

api.mapkey(';b', '#14hatena bookmark', () => {
  const { location } = window
  let url = location.href
  if (location.href.startsWith('https://app.getpocket.com/read/')) {
    url = decodeURIComponent(
      document
        .querySelector('header a')
        .getAttribute('href')
        .replace('https://getpocket.com/redirect?url=', '')
    )
  }
  if (url.startsWith('http:')) {
    tabOpenBackground(
      `http://b.hatena.ne.jp/entry/${url.replace('http://', '')}`
    )
    return
  }
  if (url.startsWith('https:')) {
    tabOpenBackground(
      `http://b.hatena.ne.jp/entry/s/${url.replace('https://', '')}`
    )
    return
  }
  throw new Error('はてなブックマークに対応していないページ')
})

api.mapkey(';g', '#14魚拓', () => {
  tabOpenLink(`https://megalodon.jp/?url=${location.href}`)
})

// org
const escapeChars = ['(', ')', "'"]
const escapeForOrg = (text) => {
  let _text = text
  escapeChars.forEach((char) => {
    _text = _text.replaceAll(char, escape(char))
  })
  return _text
}
const getUrl = (path, query) => {
  const queryString = Object.entries(query)
    .api.map(
      ([key, value]) =>
        `${encodeURIComponent(key)}=${escapeForOrg(encodeURIComponent(value))}`
    )
    .join('&')
  return [path, queryString].join('?')
}
const orgCapture = (template) => {
  const url = getUrl('org-protocol://capture', {
    template,
    url: window.location.href,
    title: document.title.replace(/\|/g, '-'),
    body: window.getSelection(),
  })
  console.log(`orgCapture: ${url}`)
  window.location.href = url
}
api.mapkey('ocm', '#14org-capture memo', () => {
  orgCapture('M')
})
api.mapkey('oct', '#14org-capture todo', () => {
  orgCapture('T')
})
api.mapkey('ocl', '#14org-capture read it later', () => {
  orgCapture('L')
})

api.mapkey('=q', '#14Delete query', () => {
  location.href = location.href.replace(/\?.*/, '')
})
api.mapkey('=h', '#14Delete hash', () => {
  location.href = location.href.replace(/\#.*/, '')
})
// 15: Insert Mode

// ---- qmarks ----
const qmarksMapKey = (prefix, urls, newTab) => {
  const openLink = (link, newTab) => () => {
    RUNTIME('openLink', {
      tab: { tabbed: newTab },
      url: link,
    })
  }
  for (const key in urls) {
    api.mapkey(prefix + key, `qmark: ${urls[key]}`, openLink(urls[key], newTab))
  }
}
const qmarksUrls = {
  m: 'https://mail.google.com/mail/u/0/',
  h: 'http://b.hatena.ne.jp/hush_in/hotentry',
  i: 'https://www.instapaper.com/u',
  tw: 'https://twitter.com/',
  td: 'https://tweetdeck.twitter.com/',
}
api.unmap('gn')
qmarksMapKey('gn', qmarksUrls, true)
qmarksMapKey('gO', qmarksUrls, false)

// --- Site-specific mappings ---
const clickElm = (selector) => () => document.querySelector(selector).click()
if (/speakerdeck.com/.test(window.location.hostname)) {
  const clickElmFr = (selector) => () =>
    document
      .querySelector('.speakerdeck-iframe')
      .contentWindow.document.querySelector(selector)
      .click()
  api.mapkey(']', 'next page', clickElmFr('.sd-player-next'))
  api.mapkey('[', 'prev page', clickElmFr('.sd-player-previous'))
}

if (/www.slideshare.net/.test(window.location.hostname)) {
  api.mapkey(']', 'next page', clickElm('.j-next-btn'))
  api.mapkey('[', 'prev page', clickElm('.j-prev-btn'))
}

if (/booklog.jp/.test(window.location.hostname)) {
  api.mapkey(']', 'next page', clickElm('#modal-review-next'))
  api.mapkey('[', 'prev page', clickElm('#modal-review-prev'))
  api.mapkey('d', '読み終わった', clickElm('#status3'))
  api.mapkey('R', 'Read by Kindle', () =>
    RUNTIME('openLink', {
      tab: { tabbed: true },
      url: `https://read.amazon.co.jp/?asin=${document
        .querySelector('.item-area-info-title a')
        .getAttribute('href')
        .replace(/.*\//, '')}`,
    })
  )
}

if (/www.amazon.co.jp/.test(window.location.hostname)) {
  api.mapkey('=s', '#14URLを短縮', () => {
    location.href = `https://www.amazon.co.jp/dp/${
      document.querySelectorAll("[name='ASIN'], [name='ASIN.0']")[0].value
    }`
  })
}

if (
  /^https:\/\/b.hatena.ne.jp\/.*\/hotentry\?date/.test(window.location.href)
) {
  const moveDate = (diff) => () => {
    const url = new URL(window.location.href)
    const dateTxt = url.searchParams.get('date')
    const [_, yyyy, mm, dd] = dateTxt.match(/(....)(..)(..)/)
    const date = new Date(
      parseInt(yyyy, 10),
      parseInt(mm, 10) - 1,
      parseInt(dd, 10) + diff
    )
    url.searchParams.set('date', formatDate(date, 'YYYYMMDD'))
    location.href = url.href
  }
  api.mapkey(']]', 'next date', moveDate(1))
  api.mapkey('[[', 'prev date', moveDate(-1))
}

if (/youtube.com/.test(window.location.hostname)) {
  api.mapkey(
    'F',
    'Toggle fullscreen',
    clickElm('.ytp-fullscreen-button.ytp-button')
  )
  api.mapkey(
    'gH',
    'GoTo Home',
    () => (location.href = 'https://www.youtube.com/feed/subscriptions?flow=2')
  )
}

api.unmapAllExcept(
  ['E', 'R', 'd', 'u', 'T', 'f', 'F', 'C', 'x', 'S', 'H', 'L', 'cm'],
  /mail.google.com|twitter.com|feedly.com|i.doit.im/
)

// ------------------------------------------------------------
// style
api.Hints.style('text-shadow: -1px -1px 2px black, 1px -1px 2px black, -1px 1px 2px black, 1px 1px 2px black; color: #33cccc; font-size: 16pt; font-family: Cica, "ヒラギノ角ゴ Pro", Avenir, sans-serif;text-transform: lowercase; background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#565756), color-stop(100%,#444444)); border: 1px solid #E4E4E4; opacity: 1.0; text-shadow: none !important;')
api.Hints.style (`font-family: Cica; font-size: 16pt; text-transform: lowercase;`, "text")
// theme
settings.theme = `
.sk_theme {
  font-family: Cica;
  font-size: 18pt;
}
#sk_status, #sk_find {
  font-family: Cica;
  font-size: 18pt;
}
#sk_omnibarSearchResult {
  font-family: Cica;
  font-size: 18pt;
} 
#sk_omnibarSearchResult .highlight {
  background: #f9ec89;
}
`;

// click `Save` button to make above settings to take effect.span style='color:#f
