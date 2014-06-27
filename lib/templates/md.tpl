<% schema.forEach(function(data) { %>

## 接口名 
<%= data.title %>

### 接口描述 
<%= data.description %>

### 方法 
<%= data.type %>

### 参数
```javascript
<%= JSON.stringify(data.params, null, '\t') %>

```

### 返回值 
#### 成功 
```javascript
<%= JSON.stringify(data.success, null, '\t') %>

```
#### 失败 
```javascript
<%= JSON.stringify(data.error, null, '\t') %>

```


### 其他说明:
	<%= data.other %>

<% }) %>