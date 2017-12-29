import React, { PropTypes } from 'react';

import './layout.less';

const width = document.documentElement.clientWidth;
const height = document.documentElement.clientHeight;


const style = {
    width, height,
    background: '#ccc'
}
const topStyle = {
    width,
    height: 45
}
const rowStyle = {
    width,
    height: style.height - topStyle.height
}
const lStyle = {
    width: rowStyle.height * 0.7,
    height: rowStyle.height
}
const rStyle = {
    width: width - lStyle.width,
    height: rowStyle.height
}

const Layout = props => {

    return (
        <div className="layout" style={style}>
            <div className="top" style={{ ...topStyle, overflow: 'hidden' }}>
            {
                React.cloneElement( props.children[0], {...topStyle})
            }
            </div>
            <div className="row" style={rowStyle}>
            <div className="left" style={lStyle}>
                {React.cloneElement(props.children[1], { width: lStyle.width, height: lStyle.width })}
                {React.cloneElement(props.children[2], { width: lStyle.width, height: lStyle.height - lStyle.width })}
            </div>
            <div className="right" style={rStyle}>
                {React.cloneElement(props.children[3], { ...rStyle })}
            </div>
            </div>
        </div>
    )
};

export default Layout;