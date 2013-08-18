Header =
  init: ->
    @menu = new UI.Menu 'header'

    menuButton = $.el 'span',
      className: 'menu-button'
      innerHTML: '<i></i>'

    barFixedToggler  = $.el 'label',
      innerHTML: '<input type=checkbox name="Fixed Header"> Fixed Header'
    headerToggler = $.el 'label',
      innerHTML: '<input type=checkbox name="Header auto-hide"> Auto-hide header'
    barPositionToggler = $.el 'label',
      innerHTML: '<input type=checkbox name="Bottom header"> Bottom header'
    linkJustifyToggler = $.el 'label',
      innerHTML: "<input type=checkbox #{if Conf['Centered links'] then 'checked' else ''}> Centered links"
    customNavToggler = $.el 'label',
      innerHTML: '<input type=checkbox name="Custom Board Navigation"> Custom board navigation'
    footerToggler = $.el 'label',
      innerHTML: "<input type=checkbox #{unless Conf['Bottom Board List'] then 'checked' else ''}> Hide bottom board list"
    shortcutToggler = $.el 'label',
      innerHTML: "<input type=checkbox #{unless Conf['Shortcut Icons'] then 'checked' else ''}> Shortcut Icons"
    editCustomNav = $.el 'a',
      textContent: 'Edit custom board navigation'
      href: 'javascript:;'

    @barFixedToggler    = barFixedToggler.firstElementChild
    @barPositionToggler = barPositionToggler.firstElementChild
    @linkJustifyToggler = linkJustifyToggler.firstElementChild
    @headerToggler      = headerToggler.firstElementChild
    @footerToggler      = footerToggler.firstElementChild
    @shortcutToggler      = shortcutToggler.firstElementChild
    @customNavToggler   = customNavToggler.firstElementChild

    $.on menuButton,          'click',  @menuToggle
    $.on @barFixedToggler,    'change', @toggleBarFixed
    $.on @barPositionToggler, 'change', @toggleBarPosition
    $.on @linkJustifyToggler, 'change', @toggleLinkJustify
    $.on @headerToggler,      'change', @toggleBarVisibility
    $.on @footerToggler,      'change', @toggleFooterVisibility
    $.on @shortcutToggler,      'change', @toggleShortcutIcons
    $.on @customNavToggler,   'change', @toggleCustomNav
    $.on editCustomNav,       'click',  @editCustomNav

    @setBarFixed      Conf['Fixed Header']
    @setBarVisibility Conf['Header auto-hide']
    @setLinkJustify   Conf['Centered links']
    @setShortcutIcons Conf['Shortcut Icons']

    $.sync 'Fixed Header',     Header.setBarFixed
    $.sync 'Bottom Header',    Header.setBarPosition
    $.sync 'Shortcut Icons',   Header.setShortcutIcons
    $.sync 'Header auto-hide', Header.setBarVisibility
    $.sync 'Centered links',   Header.setLinkJustify

    @addShortcut menuButton

    $.event 'AddMenuEntry',
      type: 'header'
      el: $.el 'span',
        textContent: 'Header'
      order: 107
      subEntries: [
        {el: barFixedToggler}
        {el: headerToggler}
        {el: barPositionToggler}
        {el: linkJustifyToggler}
        {el: footerToggler}
        {el: shortcutToggler}
        {el: customNavToggler}
        {el: editCustomNav}
      ]

    $.on window, 'load hashchange', Header.hashScroll
    $.on d, 'CreateNotification', @createNotification

    $.asap (-> d.body), =>
      return unless Main.isThisPageLegit()
      # Wait for #boardNavMobile instead of #boardNavDesktop,
      # it might be incomplete otherwise.
      $.asap (-> $.id('boardNavMobile') or d.readyState isnt 'loading'), Header.setBoardList
      $.prepend d.body, @bar
      $.add d.body, Header.hover
      @setBarPosition Conf['Bottom Header']
      @

    $.ready =>
      @footer = $.id 'boardNavDesktopFoot'
      if a = $ "a[href*='/#{g.BOARD}/']", $.id 'boardNavDesktopFoot'
        a.className = 'current'

      cs = $.el 'a',
        id: 'settingsWindowLink'
        href: 'javascript:;'
        textContent: 'Catalog Settings'

      @addShortcut cs if g.VIEW is 'catalog'

      Header.setFooterVisibility Conf['Bottom Board List']
      $.sync 'Bottom Board List', Header.setFooterVisibility

    @enableDesktopNotifications()

  bar: $.el 'div',
    id: 'header-bar'

  notify: $.el 'div',
    id: 'notifications'

  shortcuts: $.el 'span',
    id: 'shortcuts'

  hover: $.el 'div',
    id: 'hoverUI'

  toggle: $.el 'div',
    id: 'scroll-marker'

  setBoardList: ->
    fourchannav = $.id 'boardNavDesktop'
    if a = $ "a[href*='/#{g.BOARD}/']", fourchannav
      a.className = 'current'
    boardList = $.el 'span',
      id: 'board-list'
      innerHTML: "<span id=custom-board-list></span><span id=full-board-list hidden><span class='hide-board-list-container brackets-wrap'><a href=javascript:; class='hide-board-list-button'>&nbsp;-&nbsp;</a></span> #{fourchannav.innerHTML}</span>"
    fullBoardList = $ '#full-board-list', boardList
    btn = $ '.hide-board-list-button', fullBoardList
    $.on btn, 'click', Header.toggleBoardList

    $.rm $ '#navtopright', fullBoardList
    $.add boardList, fullBoardList
    $.add Header.bar, [boardList, Header.shortcuts, Header.notify, Header.toggle]

    Header.setCustomNav Conf['Custom Board Navigation']
    Header.generateBoardList Conf['boardnav'].replace /(\r\n|\n|\r)/g, ' '

    $.sync 'Custom Board Navigation', Header.setCustomNav
    $.sync 'boardnav', Header.generateBoardList

  generateBoardList: (text) ->
    list = $ '#custom-board-list', Header.bar
    $.rmAll list
    return unless text
    as = $$ '#full-board-list a[title]', Header.bar
    nodes = text.match(/[\w@]+((-(all|title|replace|full|index|catalog|url:"[^"]+[^"]"|text:"[^"]+")|\,"[^"]+[^"]"))*|[^\w@]+/g).map (t) ->
      if /^[^\w@]/.test t
        return $.tn t
      if /^toggle-all/.test t
        a = $.el 'a',
          className: 'show-board-list-button'
          textContent: (t.match(/-text:"(.+)"/) || [null, '+'])[1]
          href: 'javascript:;'
        $.on a, 'click', Header.toggleBoardList
        return a
      if /^external/.test t
        a = $.el 'a',
          href: (t.match(/\,"(.+)"/) || [null, '+'])[1]
          textContent: (t.match(/-text:"(.+)"\,/) || [null, '+'])[1]
          className: 'external'
        return a
      board = if /^current/.test t
        g.BOARD.ID
      else
        t.match(/^[^-]+/)[0]
      for a in as
        if a.textContent is board
          a = a.cloneNode true

          a.textContent = if /-title/.test(t) or /-replace/.test(t) and $.hasClass a, 'current'
            a.title
          else if /-full/.test t
            "/#{board}/ - #{a.title}"
          else if m = t.match /-text:"(.+)"/
            m[1]
          else
            a.textContent

          if m = t.match /-(index|catalog)/
            a.dataset.only = m[1]
            a.href = "//boards.4chan.org/#{board}/"
            if m[1] is 'catalog'
              if Conf['External Catalog']
                a.href = CatalogLinks.external board
              else
                a.href += 'catalog'
              $.addClass a, 'catalog'

          $.addClass a, 'navSmall' if board is '@'
          return a
      $.tn t
    $.add list, nodes

  toggleBoardList: ->
    {bar}  = Header
    custom = $ '#custom-board-list', bar
    full   = $ '#full-board-list',   bar
    showBoardList = !full.hidden
    custom.hidden = !showBoardList
    full.hidden   =  showBoardList

  setBarPosition: (bottom) ->
    Header.barPositionToggler.checked = bottom
    if bottom
      $.rmClass  doc, 'top'
      $.addClass doc, 'bottom'
      $.after Header.bar, Header.notify
    else
      $.rmClass  doc, 'bottom'
      $.addClass doc, 'top'
      $.add Header.bar, Header.notify

  setLinkJustify: (centered) ->
    Header.linkJustifyToggler.checked = centered
    if centered
      $.addClass doc, 'centered-links'
    else
      $.rmClass doc, 'centered-links'

  toggleBarPosition: ->
    $.event 'CloseMenu'

    Header.setBarPosition @checked

    Conf['Bottom Header'] = @checked
    $.set 'Bottom Header',  @checked

  toggleLinkJustify: ->
    $.event 'CloseMenu'
    centered = if @nodeName is 'INPUT'
      @checked
    Header.setLinkJustify centered
    $.set 'Centered links', centered

  setBarFixed: (fixed) ->
    Header.barFixedToggler.checked = fixed
    if fixed
      $.addClass doc, 'fixed'
      $.addClass Header.bar, 'dialog'
    else
      $.rmClass doc, 'fixed'
      $.rmClass Header.bar, 'dialog'

  toggleBarFixed: ->
    $.event 'CloseMenu'

    Header.setBarFixed @checked

    Conf['Fixed Header'] = @checked
    $.set 'Fixed Header',  @checked

  setShortcutIcons: (show) ->
    Header.shortcutToggler.checked = show
    if show
      $.addClass doc, 'shortcut-icons'
    else
      $.rmClass doc, 'shortcut-icons'

  toggleShortcutIcons: ->
    $.event 'CloseMenu'

    Header.setShortcutIcons @checked

    Conf['Shortcut Icons'] = @checked
    $.set 'Shortcut Icons',  @checked

  setBarVisibility: (hide) ->
    Header.headerToggler.checked = hide
    $.event 'CloseMenu'
    (if hide then $.addClass else $.rmClass) Header.bar, 'autohide'
    (if hide then $.addClass else $.rmClass) doc, 'autohide'

  toggleBarVisibility: ->
    hide = if @nodeName is 'INPUT'
      @checked
    else
      !$.hasClass Header.bar, 'autohide'
    # set checked status if called from keybind
    @checked = hide

    $.set 'Header auto-hide', Conf['Header auto-hide'] = hide
    Header.setBarVisibility hide
    message = "The header bar will #{if hide
      'automatically hide itself.'
    else
      'remain visible.'}"
    new Notice 'info', message, 2

  setFooterVisibility: (hide) ->
    Header.footerToggler.checked = hide
    Header.footer.hidden = hide

  toggleFooterVisibility: ->
    $.event 'CloseMenu'
    hide = if @nodeName is 'INPUT'
      @checked
    else
      !!Header.footer.hidden
    Header.setFooterVisibility hide
    $.set 'Bottom Board List', hide
    message = if hide
      'The bottom navigation will now be hidden.'
    else
      'The bottom navigation will remain visible.'
    new Notice 'info', message, 2

  setCustomNav: (show) ->
    Header.customNavToggler.checked = show
    cust = $ '#custom-board-list', Header.bar
    full = $ '#full-board-list',   Header.bar
    btn = $ '.hide-board-list-button', full
    [cust.hidden, full.hidden] = if show
      [false, true]
    else
      [true, false]

  toggleCustomNav: ->
    $.cb.checked.call @
    Header.setCustomNav @checked

  editCustomNav: ->
    Settings.open 'Advanced'
    settings = $.id 'fourchanx-settings'
    $('input[name=boardnav]', settings).focus()

  hashScroll: ->
    return unless (hash = @location.hash[1..]) and post = $.id hash
    return if (Get.postFromRoot post).isHidden
    Header.scrollToPost post

  scrollToPost: (post) ->
    {top} = post.getBoundingClientRect()
    if Conf['Fixed Header'] and not Conf['Bottom Header']
      headRect = Header.bar.getBoundingClientRect()
      top -= headRect.top + headRect.height
    window.scrollBy 0, top

  addShortcut: (el) ->
    shortcut = $.el 'span',
      className: 'shortcut brackets-wrap'
    $.add shortcut, el
    $.prepend Header.shortcuts, shortcut

  menuToggle: (e) ->
    Header.menu.toggle e, @, g

  createNotification: (e) ->
    {type, content, lifetime, cb} = e.detail
    notif = new Notice type, content, lifetime
    cb notif if cb

  areNotificationsEnabled: false
  enableDesktopNotifications: ->
    return unless window.Notification and Conf['Desktop Notifications']
    switch Notification.permission
      when 'granted'
        Header.areNotificationsEnabled = true
        return
      when 'denied'
        # requestPermission doesn't work if status is 'denied',
        # but it'll still work if status is 'default'.
        return

    el = $.el 'span',
      innerHTML: """
      Desktop notification permissions are not granted:<br>
      <button>Authorize</button> or <button>Disable</button>
      """
    [authorize, disable] = $$ 'button', el
    $.on authorize, 'click', ->
      Notification.requestPermission (status) ->
        Header.areNotificationsEnabled = status is 'granted'
        return if status is 'default'
        notice.close()
    $.on disable, 'click', ->
      $.set 'Desktop Notifications', false
      notice.close()
    notice = new Notice 'info', el
