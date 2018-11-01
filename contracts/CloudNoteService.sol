pragma solidity ^0.4.20;


/**
 * The contractName contract does this and that...
          用于服务云笔记的合约
 */
contract CloudNoteService {
	//用于保存每篇云笔记，key：笔记的标题  value：笔记的内容
	mapping (string => string) private note;
	//用于保存所有账户的云笔记，key：用户id value:key制定用户的所有云笔记
	mapping (string => mapping (string => string)) private data;
	//添加云笔记，id:用户ID, name:笔记标题（名称），content：笔记内容


	function addNote (string id, string name, string content) public {
		//用户ID不能为空，由于solidity语言中string类型的值不能直接比较
		//使用keccak256函数将string类型的值转换为bytes32类型进行比较

		require (keccak256(id) != keccak256(""), "id不能为空");
		//笔记标题不能为空

		require (keccak256(name) != keccak256(""), "name不能为空");
		//同一账号下，云笔记名称不能相同

		require (keccak256(data[id][name]) == keccak256(""), "note已经存在！");
		//将笔记内容添加到data变量
		data[id][name] = content;	
	}
	
	
	//更新云笔记的内容，参数与addNote函数的参数相同	
	function updateNote (string id, string name, string content) public {

		require (keccak256(id) != keccak256(""),"id不能为空");

		require (keccak256(name) != keccak256(""), "name不能为空");

		require (keccak256(content) != keccak256(""), "note已经存在！");

		//修改云笔记的内容
		data[id][name] = content;	
		
	}	

	// 根据用户ID和云笔记名称获取云笔记的内容。如果没有该云笔记，返回空
	function getNote (string id, string name) view public returns(string) {

		return data[id][name];
				
	}
	
}

