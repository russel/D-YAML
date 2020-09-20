# -*- mode: python; -*-

project(
    'D-YAML',
    'd',
    meson_version: '>=0.41.0',
    subproject_dir: 'contrib',
    version: '0.8.3'
)

src_dir = include_directories('source/')
pkgc = import('pkgconfig')

dyaml_src = [
    'source/dyaml/composer.d',
    'source/dyaml/constructor.d',
    'source/dyaml/dumper.d',
    'source/dyaml/emitter.d',
    'source/dyaml/encoding.d',
    'source/dyaml/escapes.d',
    'source/dyaml/event.d',
    'source/dyaml/exception.d',
    'source/dyaml/linebreak.d',
    'source/dyaml/loader.d',
    'source/dyaml/node.d',
    'source/dyaml/package.d',
    'source/dyaml/parser.d',
    'source/dyaml/queue.d',
    'source/dyaml/reader.d',
    'source/dyaml/representer.d',
    'source/dyaml/resolver.d',
    'source/dyaml/scanner.d',
    'source/dyaml/serializer.d',
    'source/dyaml/style.d',
    'source/dyaml/tagdirective.d',
    'source/dyaml/token.d'
]

dyaml_test_src = [
    'source/dyaml/test/common.d',
    'source/dyaml/test/compare.d',
    'source/dyaml/test/constructor.d',
    'source/dyaml/test/emitter.d',
    'source/dyaml/test/errors.d',
    'source/dyaml/test/inputoutput.d',
    'source/dyaml/test/reader.d',
    'source/dyaml/test/representer.d',
    'source/dyaml/test/resolver.d',
    'source/dyaml/test/tokens.d',
]

install_headers(dyaml_src, install_dir: 'include/d/dyaml/')

tinyendian_dep = dependency('tinyendian', version: '>=0.2.0', fallback: ['tinyendian', 'tinyendian_dep'])

library_name = 'dyaml'

dyaml_lib = library(
    library_name,
    [dyaml_src],
    include_directories: [src_dir],
    dependencies: [tinyendian_dep],
    install: true,
    version: meson.project_version(),
    pic: true,
)

pkgc.generate(
    name: library_name,
    libraries: dyaml_lib,
    subdirs: 'd/yaml/',
    version: meson.project_version(),
    description: 'YAML parser and emitter for the D programming language.'
)

# Make D-YAML easy to use as subproject
dyaml_dep = declare_dependency(
    link_with: dyaml_lib,
    include_directories: [src_dir],
    dependencies: [tinyendian_dep]
)
