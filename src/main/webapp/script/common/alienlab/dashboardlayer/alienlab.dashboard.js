/**
 * alienlab业务看板组件
 */
(function($,window){
	$.alienlab={
			//业务看板引擎
			dashboardEngine:function(engineconfig){
				//读取参数配置
				this. _params=engineconfig.params;
				//读取数据组配置
				this. _datagroups=[];
				//循环初始化groups，数据组
				if(engineconfig.groups){
					for(var i=0;i<engineconfig.groups.length;i++){
						this. _datagroups.push(new $.alienlab.dataGroup(engineconfig.groups[i]));
					}
				}
				//对象级变量
				var _this=this;
				
				//渲染数据组
				this.rendergroup=function(div){
					if(_this._datagroups.length<=0)return;
					for(var i=0;i<_this._datagroups.length;i++){
						var dom=_this._datagroups[i].getGroupDom();
						div.append(dom);
					}
				}
				
				//根据项目key，查找项目
				this.getDataItem=function(itemkey){
					var dataItem=null;
					for(var i=0;i<_this._datagroups.length;i++){
						var items=_this._datagroups.dataItems;
						for(var j=0;j<items.length;j++){
							if(items[j].key==itemkey){
								dataItem= items[j];
								break;
							}
						}
					}
					return dataItem;
				}
			},
			dataGroup:function(groupconfig){
				var _this=this;
				this.group_name=groupconfig.name;
				this.dataItems=[];
				this.groupdom={
						container:$('<div class="ui card"></div>'),
						content:$('<div class="content"></div>'),
						header:$('<div class="header">'+groupconfig.name+'</div>'),
						meta:$('<div class="meta">点击数字查看详情</div>'),
						items:$('<div class="ui mini statistics"></div>'),
						description:$('<div class="description"></div>')
				}
				if(groupconfig.dataItems){
					var items=groupconfig.dataItems;
					for(var i=0;i<items.length;i++){
						var dataitem=new $.alienlab.dataItem(items[i]);
						_this.dataItems.push(dataitem);
					}
				}
				this.getGroupDom=function(){
					for(var i=0;i<_this.dataItems.length;i++){
						var item=_this.dataItems[i];
						var itemdom=item.getItemDom();
						_this.groupdom.items.append(itemdom.container);
						var des=_this.groupdom.description.text();
						if(des==""){
							_this.groupdom.description.text(item.text);
						}else{
							_this.groupdom.description.text(des+"，"+item.text);
						}
					}
					var group=_this.groupdom.container.append(_this.groupdom.content.append(_this.groupdom.header)
														.append(_this.groupdom.meta)
														.append(_this.groupdom.items)
														.append(_this.groupdom.description));
					return group;
				}
			},
			//业务看板项目
			dataItem:function(itemconfig){
				var _this=this;
				this.key=itemconfig.key;
				this.value=itemconfig.value;
				this.unit=itemconfig.unit;
				this.shortText=itemconfig.shortText;
				this.text=itemconfig.text;
				this.link=itemconfig.link;
				var itemdom={
						container:$('<div class="ui mini statistic">'),
						valueDom:$('<div class="value">'+_this.value+_this.unit+'</div>'),
						shortTextDom:$('<div class="label">'+_this.shortText+'</div>'),
						detaildom:$("<div class='detaildom'></div>")
				};
				itemdom.valueDom.click(function(){
					alert(_this.link);
				});
				if(itemconfig.detail){
					this.detail=new $.alienlab.detailItem(itemconfig.detail);
					this.detail.renderGrid(itemdom.detaildom);
					itemdom.detaildom.css({"max-height":"50%","max-width":"60%","overflow":"auto","background":"#fff","border":"1px solid #333"});
					itemdom.detaildom.hover(function(){
						
					},function(){
						$(this).hide();
					});
					itemdom.detaildom.hide();
					$("body").append(itemdom.detaildom);
					var timeout=0;
					itemdom.valueDom.hover(function(e){
						if(itemdom.detaildom.is(":visible")==true)return;
						$(".detaildom").hide();
						timeout=setTimeout(function(){
							itemdom.detaildom.show().css({left:(e.pageX-10),top:((e.pageY+20)-$(window).scrollTop())});
							if(itemdom.detaildom.width()+e.pageX>$(window).width()){
								itemdom.detaildom.show().css({left:($(window).width()-itemdom.detaildom.width()-10)});
							}
							if(itemdom.detaildom.height()+e.pageY-$(window).scrollTop()>$(window).height()){
								itemdom.detaildom.show().css({top:($(window).height()-itemdom.detaildom.height()-10)});
							}
							itemdom.detaildom.focus();
						},1000);
						
					},function(e){
						clearTimeout(timeout);
					});
				}
				this.getItemDom=function(){
					itemdom.container.append(itemdom.valueDom).append(itemdom.shortTextDom);
					return itemdom;
				}
			},
			//业务看板项目明细
			detailItem:function(detailconfig){
				var _this=this;
				this.key=detailconfig.key;
				this.data=detailconfig.data;
				this.fieldMapping=detailconfig.fieldMapping;
				this.renderGrid=function(dom){
					if(!_this.fieldMapping){
						return ;
					}else{
						var h_table=$('<table id="h_detail_'+_this.key+'" class="h_detailtable"></table>');
						var table=$('<table id="detail_'+_this.key+'" class="detailtable"></table>');
						var th=$('<tr class="tableheader"></tr>');
						for(var field in _this.fieldMapping){
							th.append($('<th class="headerfield" field="'+field+'">'+_this.fieldMapping[field]+'</th>'));
						}
						table.append(th);
						if(!_this.data)return ;
						for(var i=0;i<_this.data.length;i++){
							if(!_this.data[i])return;
							var row=$('<tr class="tablerow" rowindex="'+i+'"></tr>');
							for(var field in _this.fieldMapping){
								row.append($('<td class="datafield" field="'+field+'">'+_this.data[i][field]+'</td>'));
							}
							table.append(row);
						}
						dom.append(table);
						dom.append(h_table);
					}
				}
			}
	}
})($,window)