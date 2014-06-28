{{#each schemas}}

### 接口名
{{meta.title}}

### 接口描述
{{meta.description}}

### 方法
{{meta.method}}

### 参数
```javascript
{{{json params}}}

```

### 返回值
#### 成功
```javascript
{{{json sucess}}}

```
#### 失败
```javascript
{{{json error}}}

```
{{/each}}