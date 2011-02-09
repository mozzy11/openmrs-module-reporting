<%@ include file="/WEB-INF/view/module/reporting/include.jsp"%>
<%@ include file="/WEB-INF/view/module/reporting/includeScripts.jsp"%>

<style>
div.metadataForm { padding-bottom: 20px; } 
div.metadataField { display:block; margin:0; padding:6px 5px 9px 9px; clear:both; color:#444; }
div.metadataField label { line-height:100%; margin:0; padding:0 12px 3px 0; border:none; color:#222; font-weight:bold; }
div.metadataField label.desc { display:block; }
div.metadataField label.inline { display:inline; }
</style>

<c:choose>

	<c:when test="${model.mode == 'edit'}">
		<c:if test="${model.dialog != 'false'}">
			<%@ include file="/WEB-INF/view/module/reporting/localHeaderMinimal.jsp"%>
		</c:if>
		<script type="text/javascript" charset="utf-8">
			$(document).ready(function() {
		
				$('#cancelButton').click(function(event){
					<c:choose>
						<c:when test="${model.dialog != 'false'}">
							closeReportingDialog(false);
						</c:when>
						<c:otherwise>
							document.location.href = '${model.cancelUrl}';
						</c:otherwise>
					</c:choose>
				});
		
				$('#submitButton').click(function(event){
					$('#baseParameterizableEditorForm').submit();
				});
		
			});
		</script>
		
		<form id="baseParameterizableEditorForm" method="post" action="${pageContext.request.contextPath}/module/reporting/reports/saveBaseParameterizable.form">
			<input type="hidden" name="uuid" value="${model.uuid}"/>
			<input type="hidden" name="type" value="${model.type}"/>
			<input type="hidden" name="successUrl" value="${model.successUrl}"/>
			<div style="margin:0; padding:0; width:100%; padd">
				<div class="metadataField">
					<label class="desc" for="name">Name</label>
					<input type="text" id="name" tabindex="1" name="name" value="${model.obj.name}" size="50"/>
				</div>				
				<div class="metadataField">
					<label class="desc" for="type">Type</label>
					${model.obj.class.simpleName}			
				</div>				
				<div class="metadataField">
					<label class="desc" for="description">Description</label>			
					<textarea id="description" cols="80" rows="10" tabindex="2" name="description">${model.obj.description}</textarea>
				</div>
			</div>
			<hr style="color:blue;"/>
			<div style="width:100%; text-align:left;">
				<input tabindex="3" type="button" id="submitButton" class="ui-button ui-state-default ui-corner-all" value="Submit"/>
				<input tabindex="4" type="button" id="cancelButton" class="ui-button ui-state-default ui-corner-all" value="Cancel"/>
			</div>
		</form>
	</c:when>
	
	<c:otherwise>
	
		<script type="text/javascript" charset="utf-8">
			$(document).ready(function() {
				$('#${model.id}EditLink').click(function(event){
					showReportingDialog({
						title: '${model.label}',
						url: '<c:url value="/module/reporting/viewPortlet.htm?id=editBaseMetadataPortlet&url=baseMetadata&parameters=type=${model.type}|uuid=${model.uuid}|mode=edit"/>',
						successCallback: function() { window.location.reload(true); }
					});
				});
			} );
		</script>
		
		<div <c:if test="${model.size != null}">style="width:${model.size};"</c:if>>
			<b class="boxHeader" style="font-weight:bold; text-align:right;">
				<span style="float:left;">${model.label}</span>
				<a style="color:lightyellow;" href="#" id="${model.id}EditLink">Edit</a>
			</b>
			<div class="box">
				<div class="metadataForm">
					<div class="metadataField">
						<label class="inline">Name:</label>${model.obj.name}
					</div>
					<div class="metadataField">
						<label class="inline" for="type">Query Type:</label>
						${model.obj.class.simpleName}			
					</div>				
					<div class="metadataField">
						<label class="inline">Description:</label>
						<c:choose>
							<c:when test="${!empty model.obj.description}">
								${model.obj.description}
							</c:when>
							<c:otherwise>
								<i>none</i>							
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div>			
	</c:otherwise>
	
</c:choose>
