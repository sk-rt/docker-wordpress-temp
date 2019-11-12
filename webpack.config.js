const webpack = require('webpack');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
require('dotenv').config();
const BrowserSyncPlugin = require('browser-sync-webpack-plugin');

const publicPath = 'assets/';
let outputPath, devMode, sourceMap;
if (process.env.NODE_ENV === 'production') {
    outputPath = `${__dirname}/public/${publicPath}`;
    devMode = 'production';
    sourceMap = false;
} else {
    outputPath = `${__dirname}/build/${publicPath}`;
    devMode = 'development';
    sourceMap = true;
}
module.exports = {
    entry: {
        main: `${__dirname}/src/js/main.ts`
    },
    target: 'web',
    mode: devMode,
    devtool: sourceMap ? 'inline-source-map' : false,
    resolve: {
        extensions: ['.ts', '.tsx', '.js']
    },
    output: {
        path: outputPath,
        publicPath: publicPath,
        filename: 'js/[name].js'
    },
    module: {
        rules: [
            {
                enforce: 'pre',
                test: /\.ts?$/,
                use: [
                    {
                        loader: 'eslint-loader',
                        options: {
                            fix: true,
                            failOnError: true
                        }
                    }
                ]
            },
            {
                test: /\.ts$/,
                use: 'ts-loader',
                exclude: /node_modules/
            },
            {
                test: /\.(sa|sc|c)ss$/,
                use: [
                    MiniCssExtractPlugin.loader,
                    {
                        loader: 'css-loader',
                        options: {
                            sourceMap: sourceMap,
                            url: false,
                            importLoaders: 2
                        }
                    },
                    {
                        loader: 'postcss-loader',
                        options: {
                            sourceMap: sourceMap,
                            plugins: [require('autoprefixer')]
                        }
                    },
                    {
                        loader: 'sass-loader',
                        options: {
                            sourceMap: sourceMap
                        }
                    }
                ]
            }
        ]
    },
    plugins: [
        new webpack.DefinePlugin({
            ENV: JSON.stringify(devMode)
        }),
        new MiniCssExtractPlugin({
            filename: 'css/style.css'
        }),
        new BrowserSyncPlugin({
            proxy: `localhost:${process.env.LOCAL_PORT}`,
            files: ['**/*.php', '**/*.html']
        })
    ]
};
