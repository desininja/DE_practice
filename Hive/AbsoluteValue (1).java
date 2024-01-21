package udfDemo;

import org.apache.hadoop.hive.ql.exec.UDF;

public class AbsoluteValue extends UDF{

	public int evaluate (int value) {
		return Math.abs(value);
	}
}
