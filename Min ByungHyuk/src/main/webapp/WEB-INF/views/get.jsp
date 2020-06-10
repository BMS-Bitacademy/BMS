<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<%@ include file="../includes/header.jsp" %>
<style>
    .custab{
        margin: 0;
    }
</style>
<div class="row">
    <div class="container">
        <div class="content">
            <div class="container2">
                <table class="table table-striped custab">
                    <h2>종목별 세부 예상 조회 </h2>
                    <thead>
                    <tr>
                        <th class="text-center">주식명</th>
                        <th class="text-center">금일종가</th>
                        <th class="text-center">익일예측</th>
                        <th class="text-center">등락적중률</th>
                        <th class="text-center" title="3개월전 종가에서 90일 기준으로 투자를 진행한 경우">*최근3개월수익율</th>
                        <th class="text-center">평균오차범위</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <%--주식명--%>
                        <td class="text-center" style="word-break:break-all" width="175">
                            <c:out value="${model.com_name}"/>
                        </td>
                        <c:if test="${model.tod_status < 0}">

                            <%--금일종가--%>
                            <td class="text-center" style="word-break:break-all" width="175">
                                <c:out value="${model.tod_price}"/> <span class="triangle test_1"></span>
                            </td>
                        </c:if>
                        <c:if test="${model.tod_status > 0}">
                            <td class="text-center" style="word-break:break-all" width="175">
                                <c:out value="${model.tod_price}"/> <span class="triangle test_2"></span>

                            </td>
                        </c:if>
                        <%--익일예측종가--%>
                        <c:if test="${model.tom_status < 0}">
                            <td class="text-center" style="word-break:break-all" width="175">
                                <c:out value="${model.tom_price}"/><span class="bh-font-12size">(<c:out
                                    value="${model.next_day_return}"/>%)</span><span
                                    class="triangle test_1"></span>
                            </td>
                        </c:if>
                        <c:if test="${model.tom_status > 0}">
                            <td class="text-center" style="word-break:break-all" width="175">
                                <c:out value="${model.tom_price}"/><span class="bh-font-12size">(<c:out
                                    value="${model.next_day_return}"/>%)</span><span
                                    class="triangle test_2"> </span>
                            </td>
                        </c:if>
                        <c:if test="${model.tom_status == 0}">
                            <td class="text-center" style="word-break:break-all" width="175">
                                <c:out value="${model.tom_price}"/><span class="bh-font-12size">(<c:out
                                    value="${model.next_day_return}"/>%)</span>
                            </td>
                        </c:if>
                        <%--등락적중률 --%>
                        <td class="text-center" style="word-break:break-all" width="210">
                            <div class="progress">
                                <div class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0"
                                     aria-valuemax="100"
                                     style="width:<c:out value="${model.mean_match_status*100}"/>%;">
                                    <fmt:formatNumber value="${model.mean_match_status*100}"/>%
                                </div>
                            </div>
                        </td>
                        <%--최근한달수익율--%>
                        <c:if test="${model.tod_return > 1}">
                            <td class="text-center" style="word-break:break-all" width="210">
                                <div class="progress">
                                    <div class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0"
                                         aria-valuemax="100" style="width:<c:out value="${model.tod_return*40}"/>%;">
                                        <fmt:formatNumber value="${model.tod_return*100-100}"/>%
                                    </div>
                                </div>
                            </td>
                        </c:if>
                        <c:if test="${model.tod_return < 1}">
                            <td class="text-center" style="word-break:break-all" width="210">
                                <div class="progress">
                                    <div class="progress-bar bg-danger" role="progressbar" aria-valuenow="60"
                                         aria-valuemin="0"
                                         aria-valuemax="100" style="width:<c:out value="${model.tod_return*40}"/>%;">
                                        <fmt:formatNumber value="${model.tod_return*100-100}"/>%
                                    </div>
                                </div>
                            </td>
                        </c:if>
                        <%--평균오차범위--%>
                        <td class="text-center" style="word-break:break-all" width="193"><c:out
                                value="${model.mean_price_error}"/>%
                    </tr>
                    </tbody>

                </table>

                <h2><c:out value="${model.com_name}"/> 주가 예측도 </h2>
                <P class="text-center">2020-01-01 ~<c:out value="${predictDate}"/> 종가예측 그래프 </P>
                <div class="svg">
                    <svg width="1200" height="400"></svg>
                </div>
                <h2><c:out value="${model.com_name}"/> 유사한종목 </h2>
                <c:if test="${fn:length(list)==0}">
                <table class="table table-striped custab">
                    <tr>
                        <th class="text-center"> 유사 항목이 존재하지않습니다.</th>
                    </tr>
                    </c:if>
                </table>


                <c:if test="${fn:length(list)!=0}">
                    <table class="table table-striped custab">
                        <thead>
                        <tr>
                            <th class="text-center">주식명</th>
                            <th class="text-center">금일종가</th>
                            <th class="text-center">익일예측</th>
                            <th class="text-center">등락적중률</th>
                            <th class="text-center">최근3개월수익율</th>
                            <th class="text-center">평균오차범위</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${list}" var="item">
                            <%--주식명--%>
                            <tr>
                                <td style="cursor:pointer;" class="text-center text-primary" width="175"
                                    onClick=" location.href='/get?name=<c:out value="${item.com_name}"/>'">
                                    <c:out value="${item.com_name}"/>
                                </td>
                                    <%--금일종가
                                    status 증가 , 감소 ,변화없음  3개  --%>
                                <c:if test="${item.tod_status < 0}">
                                    <td class="text-center" style="word-break:break-all" width="175">
                                        <c:out value="${item.tod_price}"/> <span class="triangle test_1"></span>
                                    </td>
                                </c:if>
                                <c:if test="${item.tod_status > 0}">
                                    <td class="text-center" style="word-break:break-all" width="175">
                                        <c:out value="${item.tod_price}"/> <span class="triangle test_2"> </span>
                                    </td>
                                </c:if>
                                <c:if test="${item.tod_status == 0}">
                                    <td class="text-center" style="word-break:break-all" width="175">
                                        <c:out value="${item.tod_price}"/>
                                    </td>
                                </c:if>
                                    <%--익일예측 --%>
                                <c:if test="${item.tom_status < 0}">
                                    <td class="text-center" style="word-break:break-all" width="175">
                                        <c:out value="${item.tom_price}"/><span class="bh-font-12size">(<c:out
                                            value="${item.next_day_return}"/>%)</span><span
                                            class="triangle test_1"></span>
                                    </td>
                                </c:if>
                                <c:if test="${item.tom_status > 0}">
                                    <td class="text-center" style="word-break:break-all" width="175">
                                        <c:out value="${item.tom_price}"/><span class="bh-font-12size">(<c:out
                                            value="${item.next_day_return}"/>%)</span><span
                                            class="triangle test_2"> </span>
                                    </td>
                                </c:if>
                                <c:if test="${item.tom_status == 0}">
                                    <td class="text-center" style="word-break:break-all" width="175">
                                        <c:out value="${item.tom_price}"/><span class="bh-font-12size">(<c:out
                                            value="${item.next_day_return}"/>%)</span>
                                    </td>
                                </c:if>
                                    <%--등락적중률--%>
                                <td class="text-center" style="word-break:break-all" width="210">
                                    <div class="progress">
                                        <div class="progress-bar" role="progressbar" aria-valuenow="60"
                                             aria-valuemin="0"
                                             aria-valuemax="100"
                                             style="width:<c:out value="${item.mean_match_status*100}"/>%;">
                                            <fmt:formatNumber value="${item.mean_match_status*100}"/>%
                                        </div>
                                    </div>
                                </td>
                                    <%--최근한달수익율--%>
                                <c:if test="${item.tod_return >= 1}">
                                    <td class="text-center" style="word-break:break-all" width="210">
                                        <div class="progress">
                                            <div class="progress-bar" role="progressbar" aria-valuenow="60"
                                                 aria-valuemin="0"
                                                 aria-valuemax="100"
                                                 style="width:<c:out value="${item.tod_return*40}"/>%;">
                                                <fmt:formatNumber value="${item.tod_return*100-100}"/>%
                                            </div>
                                        </div>
                                    </td>
                                </c:if>
                                <c:if test="${item.tod_return ==0}">
                                    <td class="text-center" style="word-break:break-all" width="210">
                                        <div class="progress">
                                            <div class="progress-bar" role="progressbar" aria-valuenow="60"
                                                 aria-valuemin="0"
                                                 aria-valuemax="100"
                                                 style="width:<c:out value="${item.tod_return*40}"/>%;">
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
                                                 aria-valuemax="100"
                                                 style="width:<c:out value="${item.tod_return*40}"/>%;">
                                                <fmt:formatNumber value="${item.tod_return*100-100}"/>%
                                            </div>
                                        </div>
                                    </td>
                                </c:if>
                                    <%--오차율--%>
                                <td class="text-center" style="word-break:break-all" width="193">
                                    <fmt:formatNumber value="${item.mean_price_error}"/>%
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </c:if>
            </div>
            <button type="button" class="btn btn-primary  pull-right" onclick="location.href='view'">전체리스트로 돌아가기
            </button>
        </div>
    </div>
</div>

<!-- load the d3.js library -->
<script src="https://d3js.org/d3.v4.min.js"></script>
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
<script src="assets/js/d3.legend.js"></script>

<script>
    var svg = d3.select("svg"),
        // margin = {top: 20, right: 20, bottom: 30, left: 40}, //test
        margin = {top: 20, right: 200, bottom: 30, left: 42}, //test
        width = +svg.attr("width") - margin.left - margin.right;
    height = +svg.attr("height") - margin.top - margin.bottom;

    var parseTime = d3.timeParse("%Y-%m-%d");
    var parseDate = d3.timeFormat("%Y-%m-%d");
    bisectDate = d3.bisector(function (d) {
        return d.dateTom;
    }).left;

    var x = d3.scaleTime().range([0, width]);
    var y = d3.scaleLinear().range([height, 0]);

    var x1 = d3.scaleTime().range([0, width]);
    var y1 = d3.scaleLinear().range([height, 0]);


    var valueline = d3.line()
        .defined(d => !isNaN(d.Tod_price))
        .x(function (d) {
            return x(d.dateTod);
        })
        .y(function (d) {

            return y(d.Tod_price);
        });

    // define the 2nd line
    var valueline2 = d3.line()
        .x(function (d) {
            return x1(d.dateTom);
        })
        .y(function (d) {
            //console.log(d.getTom_price);
            return y1(d.Tom_price);
        });

    var g = svg.append("g")
        .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

    var name = '<c:out value="${model.com_name}"/>';
    var url = "http://localhost:8080/rest/getJsonList?name=" + name;
    d3.json(url, function (error, data) {
        if (error) throw error;
        data.forEach(function (d) {
            d.dateTod = parseTime(d.date);
            d.dateTom = parseTime(d.date);
            if (isNaN(d.Tod_price))
                d.Tod_price = "없음";
            else
                d.Tod_price = +d.Tod_price;

            d.Tom_price = +d.Tom_price;
            console.log(d.Tod_price);
            //console.log(d.count+1);
        });
        x.domain(d3.extent(data, function (d) {
            return d.dateTod;
        }));

        y.domain(
            [d3.min(data, function (d) {
                return Math.min(d.Tod_price * 0.9);
            }),
                d3.max(data, function (d) {
                    return Math.max(d.Tod_price);
                })
            ]);

        x1.domain(d3.extent(data, function (d) {
            return d.dateTom;
        }));
        y1.domain(
            [d3.min(data, function (d) {
                return Math.min(d.Tom_price * 0.9);
            }),
                d3.max(data, function (d) {
                    return Math.max(d.Tom_price);
                })
            ]);


        g.append("g")
            .attr("class", "axis axis--x")
            .attr("transform", "translate(0," + height + ")")
            .call(d3.axisBottom(x));

        g.append("g")
            .attr("class", "axis axis--y")
            .call(d3.axisLeft(y).ticks(6).tickFormat(function (d) {
                return parseInt(d)
            }))
            .append("text")
            .attr("class", "axis-title")
            .attr("transform", "rotate(-90)")
            .attr("y", 6)
            .attr("dy", ".71em")
            .style("text-anchor", "end")
            .attr("fill", "#5D6971");

        g.append("path")
            .datum(data)
            .attr("class", "line")
            .style("stroke", "#ff7f0e")
            .attr("d", valueline2);


        g.append("path")
            .datum(data)
            .attr("class", "line")
            .attr("d", valueline);


        var serise = ["금일종가", "명일예측"];
        var colors = d3.scaleOrdinal(d3.schemeCategory10);
        var legend = svg.append("g")
            .attr("text-anchor", "end")
            .selectAll("g")
            .data(serise)
            .enter().append("g")
            .attr("transform", function (d, i) {
                return "translate(0," + i * 20 + ")";
            });

        legend.append("rect")
            .attr("x", width + 50)
            .attr("y", 330)
            .attr("width", 19)
            .attr("height", 19)
            .attr("fill", colors);

        legend.append("text")
            .attr("x", width + 130)
            .attr("y", 340)
            .attr("dy", "0.32em")
            .text(function (d) {
                return d;
            });
        var focus = g.append("g")
            .attr("class", "focus")
            .style("display", "none");

        focus.append("line")
            .attr("class", "x-hover-line hover-line")
            .attr("y", 0)
            .attr("y", height);

        focus.append("circle")
            .attr("r", 3.5)
            .style("fill", "none")
            .style("stroke", "blue")
            .attr("r", 3);

        focus.append("text")
            .attr("x", 2)
            .attr("dy", ".10em");


        svg.append("rect")
            .attr("transform", "translate(" + margin.left + "," + margin.top + ")")
            .attr("class", "overlay")
            .attr("width", width)
            .attr("height", height)
            .on("mouseover", function () {
                focus.style("display", null);
            })
            .on("mouseout", function () {
                focus.style("display", "none");
            })
            .on("mousemove", mousemove);


        function mousemove() {
            var x0 = x.invert(d3.mouse(this)[0]),
                i = bisectDate(data, x0, 1),
                d0 = data[i - 1],
                d1 = data[i],
                d = x0 - d0.dateTom > d1.dateTom - x0 ? d1 : d0;
            focus.attr("transform", "translate(" + x(d.dateTom) + "," + y(d.Tom_price) + ")");
            focus.select("text")
                .style("font-size", "14px")
                .text("날짜: " + parseDate(d.dateTom))
                .append("tspan")
                .attr("x", 5)
                .attr("dy", "1em")
                .text("금일종가: " + d.Tod_price)
                .append("tspan")
                .attr("x", 5)
                .attr("dy", "1em")
                .text("명일예측: " + d.Tom_price);
            focus.select(".x-hover-line").attr("y1", height - y(d.Tom_price));
            focus.select(".y-hover-line").attr("x1", width + width);

        }

    });

</script>