<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="employeeHeader.jsp" %>
    <div class="content-wrapper">
        <div class="col-md-12" id="page-content">
            <form action = "externalRegistration" method = "post" style="float:right;">
	       		<input type="hidden" name="userType" value="external">
	       		<input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
	       		<button type="submit" class="btn btn-sm btn-primary">New Registration</button>
            </form>
            <h3>User Management</h3>
            <form class="form-margin" action = "searchexternaluser" method = "post">
            	<div class="col-md-3">
            		<input class="form-control" type="text" name="customerID" placeholder="Customer ID">
            	</div>
	       		<input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
	       		<button type="submit" class="btn btn-sm btn-primary">Search Customer</button>
            </form>
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">Search Results</h3>
                </div>
                <div class="panel-body no-padding">
                    <table id="content-table">
                        <thead>
                            <tr>
                                <th class="active">Customer ID</th>
                                <th class="active">Customer Email</th>
                                <th class="active">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                        	<tr>
                        		<c:choose>
	                        		<c:when test="${empty customerList}">
	                        			<tr>
	                                    	<td colspan="3">No Results</td>
	                                	</tr>
	                        		</c:when>
                        		<c:otherwise>
                        			<c:forEach items="${customerList}" var="customer">
                                		<tr>
                                			<td style="text-align:center">${customer.id}</td>
                                			<td style="text-align:center">${customer.email}</td>
                                			<td style="text-align:center">
                                				<form action = "viewaccountdetails" method = "post">
		                                    		<input type="hidden" name="extUserID" value="${customer.id}">
		                                    		<input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
		                                    		<button type="submit" class="btn btn-sm btn-primary">View Account</button>
		                                    	</form>
		                                    	<form action = "viewtransaction" method = "post">
		                                    		<input type="hidden" name="extUserID" value="${customer.id}">
		                                    		<input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
		                                    		<button type="submit" class="btn btn-sm btn-primary">View Transactions</button>
		                                    	</form>
                                			</td>
                                		</tr>
                            		</c:forEach>
                        		</c:otherwise>
                        	</c:choose>
                        		<td></td>
                        	</tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <h3>Authorization Management</h3>
            <p>${message}</p>
            <br>
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">Pending Authorization</h3>
                </div>
                <div class="panel-body no-padding">
                    <table id="content-table">
                        <thead>
                            <tr>
                            	<th class="active">Employee ID</th>
                                <th class="active">Customer ID</th>
                                <th class="active">Authorization Type</th>
                                <th class="active">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                        	<c:choose>
                        		<c:when test="${empty pendingList}">
                        			<tr>
                                    	<td colspan="2">No Pending Request</td>
                                	</tr>
                        		</c:when>
                        		<c:otherwise>
                        			<c:forEach items="${pendingList}" var="authorization">
                                		<tr>
                                			<td style="text-align:center">${authorization.internal_userID}</td>
                                			<c:choose>
			                                	<c:when test="${authorization.auth_Type == 'registration'}">
			                                    	<td style="text-align:center">N/A</td>
			                                    </c:when>
			                                    <c:otherwise>
			                                    	<td style="text-align:center">${authorization.external_userID}</td>
			                                    </c:otherwise>
		                                    </c:choose>
                                    		<td style="text-align:center">${authorization.auth_Type}</td>
                                    		<td style="text-align:center">
                                    			<form action = "processauthorization" method = "post">
		                                    		<input type="hidden" name="transactionID" value="${authorization.auth_id}">
		                                    		<input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
		                                    		<select id="requestType" name="requestType" required>
				       									<option value="">Select Type</option>
				          								<option value="approve">Approve</option>
				          								<option value="reject">Reject</option>
				       								</select>
		                                    		<button type="submit" class="btn btn-xs btn-primary">Submit</button>
		                                   		</form>
                                    		</td>
                                		</tr>
                            		</c:forEach>
                        		</c:otherwise>
                        	</c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">Completed Authorization</h3>
                </div>
                <div class="panel-body no-padding">
                    <table id="content-table">
                        <thead>
                            <tr>
                            	<th class="active">Employee ID</th>
                                <th class="active">Customer ID</th>                               
                                <th class="active">Authorization Type</th>
                                <th class="active">Option</th>
                            </tr>
                        </thead>
                        <tbody>
                        	<c:choose>
                        		<c:when test="${empty completeList}">
                        			<tr>
                                    	<td colspan="2">No Authorization</td>
                                	</tr>
                        		</c:when>
                        		<c:otherwise>
                        			<c:forEach items="${completeList}" var="authorization">
		                                <tr>
		                                	<td style="text-align:center">${authorization.internal_userID}</td>
		                                	<c:choose>
			                                	<c:when test="${authorization.auth_Type == 'registration'}">
			                                    	<td style="text-align:center">N/A</td>
			                                    </c:when>
			                                    <c:otherwise>
			                                    	<td style="text-align:center">${authorization.external_userID}</td>
			                                    </c:otherwise>
		                                    </c:choose>
		                                    <td style="text-align:center">${authorization.auth_Type}</td>
		                                    <td style="text-align:center">
		                                    	<form action = "revokeauthorization" method = "post">
		                                    		<input type="hidden" name="authID" value="${authorization.auth_id}">
		                                    		<input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
		                                    		<button type="submit" class="btn btn-sm btn-danger">Revoke Authorization</button>
		                                    	</form>
		                                    </td>
		                                </tr>
                            		</c:forEach>
                        		</c:otherwise>
                        	</c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div> <!-- .content-wrapper -->
    
</main> 
<script type="text/javascript">
    $(document).ready(function() {
        sideNavigationSettings();
    });
</script>
<script src="<c:url value="/resources/js/custom.js" />"></script>
</body>
</html>