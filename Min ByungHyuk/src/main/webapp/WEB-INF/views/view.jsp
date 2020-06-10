<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="../includes/header.jsp" %>


<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>

<div class="row">
    <div class="container">
        <div class="content">
            <div class="container">
                <table class="table table-striped custab" id="stock" class="display">
                    <h2>전체 예상 종목 </h2>
                    <thead>
                    <tr>
                        <th class="text-center">주식명</th>
                        <th class="text-center">금일종가</th>
                        <th class="text-center">익일예측</th>
                        <th class="text-center">예측등락률</th>
                        <th class="text-center">등락적중률</th>
                        <th class="text-center" title="3개월전 종가에서 90일 기준으로 투자를 진행한 경우">*최근3개월수익율</th>
                        <th class="text-center">평균오차범위</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${list}" var="item">
                        <%--주식명--%>
                        <tr>
                            <td style="cursor:pointer;" class="text-center text-primary" width="165"
                                onClick=" location.href='/get?name=<c:out value="${item.com_name}"/>'">
                                <c:out value="${item.com_name}"/>
                            </td>
                                <%--금일종가
                                status 증가 , 감소 ,변화없음  3개  --%>
                            <c:if test="${item.tod_status < 0}">
                                <td class="text-center" style="word-break:break-all">
                                    <fmt:formatNumber value="${item.tod_price}"/> <span class="triangle test_1"></span>
                                </td>
                            </c:if>
                            <c:if test="${item.tod_status > 0}">
                                <td class="text-center" style="word-break:break-all">
                                    <fmt:formatNumber value="${item.tod_price}"/> <span class="triangle test_2"> </span>
                                </td>
                            </c:if>
                            <c:if test="${item.tod_status == 0}">
                                <td class="text-center" style="word-break:break-all">
                                    <fmt:formatNumber value="${item.tod_price}"/>
                                </td>
                            </c:if>
                                <%--익일예측--%>

                            <c:if test="${item.tom_status < 0}">
                                <td class="text-center" style="word-break:break-all">
                                    <fmt:formatNumber value="${item.tom_price}"/>
                                    <span class="triangle test_1"></span>
                                </td>
                                <td class="text-center" style="word-break:break-all">
                                    <c:out value="${item.next_day_return}"/>%
                                </td>
                            </c:if>
                            <c:if test="${item.tom_status > 0}">
                                <td class="text-center" style="word-break:break-all">
                                    <fmt:formatNumber value="${item.tom_price}"/>
                                    <span class="triangle test_2"> </span>
                                </td>
                                <td class="text-center" style="word-break:break-all">
                                    <c:out value="${item.next_day_return}"/>%
                                </td>
                            </c:if>
                            <c:if test="${item.tom_status == 0}">
                                <td class="text-center" style="word-break:break-all">
                                    <fmt:formatNumber value="${item.tom_price}"/>
                                </td>
                                <td class="text-center" style="word-break:break-all">
                                    <c:out value="${item.next_day_return}"/>%
                                </td>
                            </c:if>

                            <td class="text-center" style="word-break:break-all">
                                <div class="progress">
                                    <div class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0"
                                         aria-valuemax="100"
                                         style="width:<c:out value="${item.mean_match_status*100}"/>%;">
                                        <fmt:formatNumber value="${item.mean_match_status*100}"/>%
                                    </div>
                                </div>
                            </td>
                                <%--최근한달수익율--%>
                            <c:if test="${item.tod_return >= 1}">
                                <td class="text-center" style="word-break:break-all">
                                    <div class="progress">
                                        <div class="progress-bar" role="progressbar" aria-valuenow="60"
                                             aria-valuemin="0"
                                             aria-valuemax="100" style="width:<c:out value="${item.tod_return*40}"/>%;">
                                            <fmt:formatNumber value="${item.tod_return*100-100}"/>%
                                        </div>
                                    </div>
                                </td>
                            </c:if>
                            <c:if test="${item.tod_return ==0}">
                                <td class="text-center" style="word-break:break-all">
                                    <div class="progress">
                                        <div class="progress-bar" role="progressbar" aria-valuenow="60"
                                             aria-valuemin="0"
                                             aria-valuemax="100" style="width:<c:out value="${item.tod_return*40}"/>%;">
                                            <fmt:formatNumber value="${item.tod_return*100-100}"/>%
                                        </div>
                                    </div>
                                </td>
                            </c:if>
                            <c:if test="${item.tod_return < 1}">
                                <td class="text-center" style="word-break:break-all" width="210">
                                    <div class="progress">
                                        <div class="progress-bar bg-danger" role="progressbar" aria-valuenow="60"
                                             aria-valuemin="0"
                                             aria-valuemax="100" style="width:<c:out value="${item.tod_return*40}"/>%;">
                                            <fmt:formatNumber value="${item.tod_return*100-100}"/>%
                                        </div>
                                    </div>
                                </td>
                            </c:if>
                                <%--오차율--%>
                            <td class="text-center" width="165" style="word-break:break-all">
                                <fmt:formatNumber value="${item.mean_price_error}"/>%
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>

                </table>

            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $('#stock').DataTable();

    });
</script>