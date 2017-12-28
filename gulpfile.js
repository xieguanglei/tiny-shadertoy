const gulp = require('gulp');
const tasksCreator = require('gulp-webpack-tasks-ootb');

const tasks = tasksCreator.applicationTasks({
    demo: './pages',
    react: true,
    loaders:[{
        test: /\.glsl$/,
        use: 'raw-loader'
    }]
})

gulp.task('dev', tasks.dev);
gulp.task('build', tasks.build);