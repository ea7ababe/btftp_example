btftp_example_sources = [
  'application.vala',
  'main.vala',
  'obex.vala',
  'window.vala',
]

btftp_example_deps = [
  dependency('libadwaita-1', version: '>= 1.0'),
]

gnome = import('gnome')

btftp_example_sources += gnome.compile_resources('btftp_example-resources',
  'btftp_example.gresource.xml',
  c_name: 'btftp_example'
)

executable('btftp_example', btftp_example_sources,
  vala_args: '--target-glib=2.50',  dependencies: btftp_example_deps,
  install: true,
)
