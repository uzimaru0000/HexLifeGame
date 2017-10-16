const path = require('path');

module.exports = {
    entry: {
        app: [
            './src/index.js'
        ]
    },
    output: {
        path: path.join(__dirname, '/dist'),
        filename: '[name].js'
    },
    module: {
        rules: [
            {
                test: /\.html$/,
                exclude: /node_modules/,
                use: 'file-loader?name=[name].[ext]'
            },
            {
                test: /\.elm$/,
                exclude: [/node_modules/, /elm-stuff/],
                use: [
                    'elm-hot-loader',
                    'elm-webpack-loader?debug=true'
                ]
            }
        ]
    },
    devServer: {
        inline: true,
        stats: 'errors-only'
    }
};