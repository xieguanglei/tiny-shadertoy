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

gulp.task('dev', ['shaders'], tasks.dev);
gulp.task('build', ['shaders'], tasks.build);
gulp.task('shaders', function () {
    const files = glob.sync('./pages/shaders/**/*.glsl').map(
        f => f.substring(16, f.lastIndexOf('.'))
    );
    const obj = {};
    files.forEach(function (file) {
        const dirs = file.split('/');
        const fileName = dirs.pop();
        let target = obj;
        dirs.forEach(function (dir) {
            if (!target[dir]) {
                target[dir] = {};
            }
            target = target[dir];
        });
        target[fileName] = '<<<' + file + '>>>'
    });

    let str = JSON.stringify(obj, null, 2);
    str = str.replace(/\"<<</g, 'require("./');
    str = str.replace(/>>>\"/g, '.glsl")');
    str = 'module.exports = ' + str;

    fs.outputFileSync('./pages/shaders/index.js', str);
});