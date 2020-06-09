# frozen_string_literal: true

project 'processing-core', 'https://github.com/monkstone/processing4-core' do
  model_version '4.0.0'
  id 'org.processing:core:4.0.0'
  packaging 'jar'

  description 'Jar for ruby-processing projects'

  developer 'monkstone' do
    name 'Martin Prout'
    email 'mamba2928@yahoo.co.uk'
    roles 'developer'
  end

  issue_management 'https://github.com/monkstone/processing4-core/issues', 'Github'

  source_control(url: 'https://github.com/monkstone/processing4-core',
                 connection: 'scm:git:git://github.com/monkstone/processing4-core.git',
                 developer_connection: 'scm:git:git@github.com/monkstone/processing4-core.git')

  properties('processing.api' => 'http://processing.github.io/processing-javadocs/core/',
             'source.directory' => 'src',
             'polyglot.dump.pom' => 'pom.xml',
             'project.build.sourceEncoding' => 'UTF-8',
             'jogl.version' => '2.3.2')


  jar 'org.jogamp.jogl:jogl-all:${jogl.version}'
  jar 'org.jogamp.gluegen:gluegen-rt-main:${jogl.version}'
  jar 'org.processing:video:3.0.2'

  overrides do
    plugin :resources, '3.1.0'
    plugin :dependency, '3.1.1'
    plugin(:compiler, '3.8.1',
           'release' => '11')
    plugin(:javadoc, '2.10.4',
             'detectOfflineLinks' => 'false',
             'links' => ['${processing.api}',
               '${jruby.api}'])
               plugin( :jar, '3.2.0',
                 'archive' => {
                   'manifestEntries' => {
                     'Automatic-Module-Name' =>  'org.processing.core'
                   }
                   } )
    plugin :jdeps, '3.1.2' do
      execute_goals 'jdkinternals', 'test-jdkinternals'
    end
  end

  build do
    resource do
      directory '${source.directory}/main/java'
      includes '**/**/*.glsl', '**/*.jnilib'
      excludes '**/**/*.java'
    end

    resource do
      directory '${source.directory}/main/resources'
      includes '**/*.png', '*.txt'
    end
  end
end
