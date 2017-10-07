package com.jhg.db;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.jhg.common.TypeUtils;


public class DataConvert {
	public static DataVector ConvertList(List<Map<String, Object>> list,
			String tableName) {
		DataVector table = new DataVector(tableName);
		if (list != null && list.size() > 0) {
			List<DataRow> rows = new ArrayList<DataRow>();
			for (int i = 0; i < list.size(); i++) {
				Map<String, Object> m = list.get(i);
				DataRow row = new DataRow();
				int j = 0;
				List<DataItem> items = new ArrayList<DataItem>();
				for (String key : m.keySet()) {
					String value = TypeUtils.getString(m.get(key));
					items.add(new DataItem(key, value));
					j++;
				}
				row.setItems(items);
				rows.add(row);
			}
			table.setRows(rows);
		}
		return table;
	}
}
