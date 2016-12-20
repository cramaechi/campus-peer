###
HTML Truncator for jQuery
by Henrik Nyh <http://henrik.nyh.se> 2008-02-28.
Free to modify and redistribute with credit.

Copyright (c) 2008 Henrik Nyh

Permission is hereby granted, free of charge, to any person obtaining a copy of this
software and associated documentation files (the Software), to deal in the Software 
without restriction, including without limitation the rights to use, copy, modify, merge, 
publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons 
to whom the Software is furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies 
or substantial portions of the Software. THE SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY 
OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT 
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT 
OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS 
IN THE SOFTWARE.
###

(($) ->
  recursivelyTruncate = (node, max_length) ->
    (if (node.nodeType is 3) then truncateText(node, max_length) else truncateNode(node, max_length))
  truncateNode = (node, max_length) ->
    node = $(node)
    new_node = node.clone().empty()
    truncatedChild = undefined
    node.contents().each ->
      remaining_length = max_length - new_node.text().length
      return  if remaining_length is 0
      truncatedChild = recursivelyTruncate(this, remaining_length)
      new_node.append truncatedChild  if truncatedChild

    new_node
  truncateText = (node, max_length) ->
    text = squeeze(node.data)
    text = text.replace(/^ /, "")  if trailing_whitespace
    trailing_whitespace = !!text.match(RegExp(" $"))
    text = text.slice(0, max_length)
    text = $("<div/>").text(text).html()
    text
  squeeze = (string) ->
    string.replace /\s+/g, " "
  findNodeForMore = (node) ->
    $node = $(node)
    last_child = $node.children(":last")
    return node  unless last_child
    display = last_child.css("display")
    return $node  if not display or display is "inline"
    findNodeForMore last_child
  findNodeForLess = (node) ->
    $node = $(node)
    last_child = $node.children(":last")
    return last_child  if last_child and last_child.is("p")
    node
  trailing_whitespace = true
  $.fn.truncate = (options) ->
    opts = $.extend({}, $.fn.truncate.defaults, options)
    $(this).each ->
      content_length = $.trim(squeeze($(this).text())).length
      return  if content_length <= opts.max_length
      actual_max_length = opts.max_length - opts.more.length - 3
      truncated_node = recursivelyTruncate(this, actual_max_length)
      full_node = $(this).hide()
      truncated_node.insertAfter full_node
      findNodeForMore(truncated_node).append opts.link_prefix + "<a href=\"#more\" class=\"more-less-links\"" + opts.css_more_class + "\">" + opts.more
      findNodeForLess(full_node).append opts.link_suffix + "<a href=\"#less\" class=\"more-less-links\"" + opts.css_less_class + "\">" + opts.less + "</a>"
      truncated_node.find("a:last").click ->
        truncated_node.hide()
        full_node.show()
        false

      full_node.find("a:last").click ->
        truncated_node.show()
        full_node.hide()
        false

  $.fn.truncate.defaults =
    max_length: 100
    more: "…more"
    less: "less"
    css_more_class: "truncator-link truncator-more"
    css_less_class: "truncator-link truncator-less"
    link_prefix: " ... "
    link_suffix: " "
) jQuery