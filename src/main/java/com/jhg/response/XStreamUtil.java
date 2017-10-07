package com.jhg.response;

import java.io.Writer;

import org.apache.log4j.Logger;
import org.apache.log4j.spi.LoggerFactory;

import com.jhg.db.DataItem;
import com.jhg.db.DataRow;
import com.jhg.db.DataVector;
import com.jhg.db.ExecResult;
import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.HierarchicalStreamWriter;
import com.thoughtworks.xstream.io.json.JettisonMappedXmlDriver;
import com.thoughtworks.xstream.io.json.JsonHierarchicalStreamDriver;
import com.thoughtworks.xstream.io.json.JsonWriter;

public class XStreamUtil {
	private static Logger logger = Logger.getLogger(XStreamUtil.class);

	public static String dataVector2XML(DataVector table) {
		XStream xstream = null;
		xstream = new XStream();
		try {
			// 类重命名
			xstream.alias("table", DataVector.class);
			xstream.alias("item", DataItem.class);
			xstream.alias("row", DataRow.class);
			xstream.useAttributeFor(DataItem.class, "field");
			xstream.addImplicitCollection(DataVector.class, "rows");
			xstream.addImplicitCollection(DataRow.class, "items");
			String result = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
					+ xstream.toXML(table);
			logger.info("xml转化完成：" + result);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("xml转化发生错误：" + e.getMessage() + ",可能的原因是："
					+ e.getCause().getLocalizedMessage());
			return xstream.toXML(null);
		}
	}

	public static String dataVector2JSON(DataVector table) {
		XStream xstream = null;
		xstream = new XStream(new JsonHierarchicalStreamDriver() {
			@Override
			public HierarchicalStreamWriter createWriter(Writer out) {
				return new JsonWriter(out, JsonWriter.DROP_ROOT_MODE);
			}
		});
		try {
			// xstream.setMode(XStream.NO_REFERENCES);
			// 类重命名
			xstream.alias("table", DataVector.class);
			xstream.alias("item", DataItem.class);
			xstream.alias("row", DataRow.class);
			// xstream.useAttributeFor(DataItem.class, "field");
			// xstream.addImplicitCollection(DataVector.class, "rows");
			// xstream.addImplicitCollection(DataRow.class, "items");
			String result = xstream.toXML(table);
			logger.info("JSON转化完成：" + result);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("JSON转化发生错误：" + e.getMessage() + ",可能的原因是："
					+ e.getCause().getLocalizedMessage());
			return xstream.toXML(null);
		}
	}

	public static String execResult2XML(ExecResult er) {
		XStream xstream = null;
		xstream = new XStream();
		try {
			String result = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
					+ xstream.toXML(er);
			logger.info("xml转化完成：" + result);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("xml转化发生错误：" + e.getMessage() + ",可能的原因是："
					+ e.getCause().getLocalizedMessage());
			return xstream.toXML(null);
		}
	}

	public static String execResult2JSON(ExecResult er) {
		XStream xstream = null;
		try {
			xstream = new XStream(new JettisonMappedXmlDriver());
			xstream.setMode(XStream.NO_REFERENCES);
			String result = xstream.toXML(er);
			logger.info("JSON转化完成：" + result);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("JSON转化发生错误：" + e.getMessage() + ",可能的原因是："
					+ e.getCause().getLocalizedMessage());
			return xstream.toXML(null);
		}
	}
}
