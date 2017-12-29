const gulp = require('gulp');
const tasksCreator = require('gulp-webpack-tasks-ootb');
const glob = require('glob');
const fs = require('fs-extra');

const tasks = tasksCreator.applicationTasks({
    demo: './pages',
    react: true,
    loaders: [{
        test: /\.glsl$/,
        use: 'raw-loader'
    }]
})

gulp.task('dev', tasks.dev);
gulp.task('build', tasks.build);
gulp.task('shaders', function () {
    const files = glob.sync('./pages/shaders/*.glsl').map(
        f => f.substring(16, f.lastIndexOf('.'))
    );
    const str = files.map(f =>
        `import ${f} from './${f}.glsl';`
    ).join('\n') + '\n' + 'export default {'
        + files.join(',')
        + '};';
    fs.outputFileSync('./pages/shaders/index.js', str);
});