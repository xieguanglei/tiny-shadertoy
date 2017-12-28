import React, {Component} from 'react';

import AceEditor from 'react-ace';

import 'brace';
import 'brace/mode/glsl';
import 'brace/theme/github';


const styles = {
  container: {
    height: '100%'
  }
};


class CodeEditor extends Component {

  render() {

    let {code, onCodeChange, width, height} = this.props;

    return (
      <div style={styles.container}>
        <AceEditor
          mode="glsl"
          theme="github"
          onChange={onCodeChange}
          name="example"
          width={`${width}px`}
          height={`${height}px`}
          value={code}
        />
      </div>
    )
  }
}

export default CodeEditor;
