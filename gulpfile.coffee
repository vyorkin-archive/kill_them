gulp = require 'gulp'

coffee   = require 'gulp-coffee'
concat   = require 'gulp-concat'
uglify   = require 'gulp-uglify'
imagemin = require 'gulp-imagemin'

paths = {
  scripts: ['scripts/**/*.coffee', 'scripts/**/*.js'],
  images: 'images/**/*'
}

gulp.task('scripts', ->
  gulp.src paths.scripts
    .pipe coffee()
    .pipe uglify()
    .pipe concat('all.min.js')
    .pipe gulp.dest('build/js')
)

gulp.task('images', ->
 gulp.src paths.images
    .pipe imagemin({ optimizationLevel: 5 })
    .pipe gulp.dest('build/img')
)

gulp.task('watch', ->
  gulp.watch paths.scripts, ['scripts']
  gulp.watch paths.images, ['images']
)

gulp.task 'default', ['scripts', 'images', 'watch']
