#// http://blueimp.github.com/jQuery-File-Upload/
//= require tmpl
//= require jquery.load-image
//= require jquery.iframe-transport
//= require jquery.fileupload
//= require jquery.fileupload-ui

$ ->

  fileUploadErrors =
    maxFileSize: 'File is too big',
    minFileSize: 'File is too small',
    acceptFileTypes: 'Filetype not allowed',
    maxNumberOfFiles: 'Max number of files exceeded',
    uploadedBytes: 'Uploaded bytes exceed file size',
    emptyResult: 'Empty file upload result'
  
  $fu = $('#fileupload')
  $files = $('#fileupload').find('.files')
  
  $fu.fileupload
    autoUpload: true,
    destroy: (e, data) ->
      $.blueimpUI.fileupload.prototype.options.destroy.call(this, e, data) if confirm "Are you sure you want to delete this file?"

  $.getJSON $('#fileupload').prop('action'), (files) ->
    fu = $('#fileupload').data('fileupload')
    fu._adjustMaxNumberOfFiles(-files.length)
    template = fu._renderDownload(files).appendTo($('#fileupload .files'))
    #// Force reflow:
    fu._reflow = fu._transition && template.length && template[0].offsetWidth
    template.addClass('in')
