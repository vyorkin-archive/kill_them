gulp    = require 'gulp'
plugins = require('gulp-load-plugins')()

paths = {
  scripts: {
    lib: [
      'bower_components/requirejs/require.js',
      'bower_components/phaser/phaser.min.js'
    ],
    app: ['scripts/**/*.coffee']
  },
  styles: {
    app: ['styles/**/*.scss']
  },
  assets: 'assets/**/*.*',
  pages: 'pages/*.haml'
}

gulp.task 'lint', ->
  gulp.src paths.scripts.app
    .pipe plugins.cached 'lint'
    .pipe plugins.coffeelint()
    .pipe plugins.coffeelint.reporter()
    .pipe plugins.notify 'coffeescript lint complete'

gulp.task 'libjs', ->
  gulp.src paths.scripts.lib
    .pipe plugins.changed('build/js', { extension: '.js' })
    # .pipe plugins.uglify()
    # .pipe plugins.concat('lib.min.js')
    .pipe plugins.size({ showFiles: true })
    .pipe gulp.dest('build/js')
    .pipe plugins.notify 'library scripts build complete'

gulp.task 'minify', ['styles', 'libjs', 'appjs']

gulp.task 'appjs', ->
  gulp.src paths.scripts.app
    .pipe plugins.changed('build/js', { extension: '.js' })
    .pipe plugins.coffee()
    # .pipe plugins.uglify()
    # .pipe plugins.concat('app.min.js')
    .pipe plugins.size({ showFiles: true })
    .pipe gulp.dest('build/js')
    .pipe plugins.notify 'application scripts build complete'

gulp.task 'assets', ->
  gulp.src paths.assets
    .pipe gulp.dest('build/assets')
    .pipe plugins.notify 'assets build complete'

gulp.task 'styles', ->
  gulp.src paths.styles.app
    .pipe plugins.changed('build/css', { extension: '.css' })
    .pipe plugins.rubySass()
    .pipe plugins.size({ showFiles: true })
    .pipe gulp.dest('build/css')
    .pipe plugins.notify 'scss to css conversion complete'

gulp.task 'pages', ->
  gulp.src paths.pages
    .pipe plugins.cached('pages')
    .pipe plugins.changed('build/', { extension: '.html' })
    .pipe plugins.rubyHaml()
    .pipe plugins.minifyHtml()
    .pipe gulp.dest('build/')
    .pipe plugins.notify 'haml to html conversion complete'

gulp.task 'clean', ->
  gulp.src ['build/*.html', 'build/css/*.css', 'build/js/*.js']
    .pipe plugins.clean()

gulp.task 'watch', ->
  gulp.watch paths.scripts.app, ['lint', 'appjs']
  gulp.watch paths.scripts.lib, ['libjs']
  gulp.watch paths.styles.app, ['styles']
  gulp.watch paths.assets, ['assets']
  gulp.watch paths.pages, ['pages']

# TODO: Add task to build texture atlases

gulp.task 'default', ['lint', 'minify', 'pages', 'assets', 'watch']
