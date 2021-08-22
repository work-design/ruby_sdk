Gem::Specification.new do |s|
  s.name = 'work_design'
  s.version = '0.1'
  s.authors = ['qinmingyuan']
  s.email = ['mingyuan0715@foxmail.com']
  s.homepage = 'https://github.com/work-design/ruby_sdk'
  s.summary = '集成 work-design 微服务'
  s.description = 'Description of RubySdk.'
  s.license = 'MIT'

  s.metadata['homepage_uri'] = s.homepage
  s.metadata['source_code_uri'] = 'https://github.com/work-design/ruby_sdk'
  s.metadata['changelog_uri'] = 'https://github.com/work-design/ruby_sdk'

  s.files = Dir[
    '{app,config,db,lib}/**/*',
    'LICENSE',
    'Rakefile',
    'README.md'
  ]

  s.add_dependency 'rails', '~> 6.1'
  s.add_dependency 'httpx', '~> 0.16'
end
