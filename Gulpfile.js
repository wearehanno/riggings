var gulp = require('gulp');
var sass = require('gulp-sass');
var sourcemaps = require('gulp-sourcemaps');
var autoprefixer = require('gulp-autoprefixer');

// A detailed debugging task to get more output
// Call it with 'gulp debug' to start a watcher
gulp.task('styles-devdebug', function() {
    gulp.src('source-sass/app.scss')
      .pipe(sourcemaps.init())
      .pipe(sass().on('error', sass.logError))
      .pipe(autoprefixer())
      .pipe(sourcemaps.write('.'))
      .pipe(gulp.dest('./source/assets/stylesheets/'));
});
gulp.task('debug',function() {
    gulp.watch('source-sass/**',['styles-devdebug']);
});

// This is stripped back with minimal debugging so that it's faster to compile
gulp.task('default', function() {
    gulp.src('source-sass/app.scss')
      .pipe(sass().on('error', sass.logError))
      .pipe(gulp.dest('./source/assets/stylesheets/'));
});
//Call it with 'gulp watch' on the command line to start a watcher
gulp.task('watch',function() {
    gulp.watch('source-sass/**',['default']);
});

// This is the dist task, for the live server. Call it with 'gulp dist'
gulp.task('dist', function() {
    gulp.src('source-sass/app.scss')
      .pipe(sass().on('error', sass.logError))
      .pipe(autoprefixer())
      .pipe(gulp.dest('./source/assets/stylesheets/'));
});