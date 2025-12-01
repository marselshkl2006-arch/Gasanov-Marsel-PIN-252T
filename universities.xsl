<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="UTF-8"/>

<xsl:template match="/">
<html>
<head>
    <title>Высшие учебные заведения Омска</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background: #f5f5f5; }
        .university { border: 2px solid #333; margin: 20px 0; padding: 20px; border-radius: 10px; background: white; }
        .omgtu { background-color: #e8f4f8; border-color: #007acc; }
        .omgu { background-color: #f0e8f8; border-color: #8a2be2; }
        .sibadi { background-color: #f8f0e8; border-color: #d2691e; }
        .faculty { margin: 15px 0; padding: 15px; background: #f9f9f9; border-left: 4px solid #007acc; }
        .department { margin: 10px 0; padding: 10px; background: #fff; border: 1px solid #ddd; }
        .photo-gallery { display: flex; flex-wrap: wrap; gap: 10px; margin: 15px 0; }
        .photo-item { border: 1px solid #ccc; padding: 10px; width: 200px; background: white; }
        .achievement { background: #e7f7e7; padding: 10px; margin: 5px 0; border-radius: 5px; }
        h1 { color: #333; text-align: center; }
        h2 { color: #333; border-bottom: 2px solid #333; padding-bottom: 5px; }
        .university-header { display: flex; justify-content: space-between; align-items: center; }
        .university-badge { padding: 5px 10px; border-radius: 15px; color: white; font-weight: bold; }
        .omgtu-badge { background: #007acc; }
        .omgu-badge { background: #8a2be2; }
        .sibadi-badge { background: #d2691e; }
        .priority-badge { background: #ff6600; color: white; padding: 3px 8px; border-radius: 10px; font-size: 12px; margin-left: 10px; }
    </style>
</head>
<body>
    <h1>Высшие учебные заведения города Омска</h1>
    
    <div style="margin: 20px 0; padding: 15px; background: white; border-radius: 10px; border: 1px solid #ddd;">
        <h3 style="margin-top: 0;">Статистика:</h3>
        <p>Всего университетов: <strong><xsl:value-of select="count(//university)"/></strong></p>
        <p>Всего факультетов: <strong><xsl:value-of select="count(//faculty)"/></strong></p>
        <p>Всего кафедр: <strong><xsl:value-of select="count(//department)"/></strong></p>
    </div>
    
    <xsl:apply-templates select="universities/university"/>
    
</body>
</html>
</xsl:template>

<xsl:template match="university">
    <div class="university">
        <xsl:choose>
            <xsl:when test="@id='omgtu1'">
                <xsl:attribute name="class">university omgtu</xsl:attribute>
            </xsl:when>
            <xsl:when test="@id='omgu2'">
                <xsl:attribute name="class">university omgu</xsl:attribute>
            </xsl:when>
            <xsl:when test="@id='sibadi3'">
                <xsl:attribute name="class">university sibadi</xsl:attribute>
            </xsl:when>
        </xsl:choose>
        
        <div class="university-header">
            <h2>
                <xsl:value-of select="name"/>
                <xsl:if test="abbreviation">
                    <xsl:text> (</xsl:text>
                    <xsl:value-of select="abbreviation"/>
                    <xsl:text>)</xsl:text>
                </xsl:if>
            </h2>
            <span class="university-badge">
                <xsl:choose>
                    <xsl:when test="@id='omgtu1'">
                        <xsl:attribute name="class">university-badge omgtu-badge</xsl:attribute>
                        Технический
                    </xsl:when>
                    <xsl:when test="@id='omgu2'">
                        <xsl:attribute name="class">university-badge omgu-badge</xsl:attribute>
                        Классический
                    </xsl:when>
                    <xsl:when test="@id='sibadi3'">
                        <xsl:attribute name="class">university-badge sibadi-badge</xsl:attribute>
                        Автодорожный
                    </xsl:when>
                </xsl:choose>
            </span>
        </div>
        
        <p><strong>Статус:</strong> <xsl:value-of select="status"/></p>
        <p><strong>Год основания:</strong> <xsl:value-of select="foundation_year"/></p>
        <p><strong>Тип:</strong> <xsl:value-of select="@type"/></p>
        <p><strong>Аккредитация:</strong> <xsl:value-of select="@accreditation"/></p>
        
        <div class="contact-info">
            <h3>Контактная информация:</h3>
            <p>
                <xsl:value-of select="contact_info/address/city"/>,
                <xsl:value-of select="contact_info/address/street"/>,
                д. <xsl:value-of select="contact_info/address/house"/>
                <xsl:if test="contact_info/address/building">
                    , корп. <xsl:value-of select="contact_info/address/building"/>
                </xsl:if>
            </p>
            <p><strong>Телефоны:</strong></p>
            <ul>
                <xsl:for-each select="contact_info/phones/phone">
                    <li>
                        <xsl:value-of select="."/>
                        <xsl:if test="@type">
                            (<xsl:value-of select="@type"/>)
                        </xsl:if>
                    </li>
                </xsl:for-each>
            </ul>
            <p><strong>Email:</strong> <xsl:value-of select="contact_info/email"/></p>
            <p><strong>Сайт:</strong> 
                <a href="{contact_info/website}" target="_blank">
                    <xsl:value-of select="contact_info/website"/>
                </a>
            </p>
        </div>
        
        <p><strong>Описание:</strong> <xsl:value-of select="description"/></p>
        
        <div class="faculties">
            <h3>Факультеты (<xsl:value-of select="count(faculties/faculty)"/>):</h3>
            <xsl:apply-templates select="faculties/faculty"/>
        </div>
        
        <xsl:if test="gallery">
            <div class="gallery">
                <h3>Фотогалерея:</h3>
                <div class="photo-gallery">
                    <xsl:apply-templates select="gallery/photo"/>
                </div>
            </div>
        </xsl:if>
        
        <xsl:if test="achievements">
            <div class="achievements">
                <h3>Достижения:</h3>
                <xsl:apply-templates select="achievements/achievement"/>
            </div>
        </xsl:if>
    </div>
</xsl:template>

<xsl:template match="faculty">
    <div class="faculty">
        <xsl:if test="@priority='high'">
            <xsl:attribute name="style">border-left-color: #ff6600; background: #fff0e6;</xsl:attribute>
        </xsl:if>
        
        <h4>
            <xsl:value-of select="name"/>
            <xsl:if test="abbreviation">
                <xsl:text> (</xsl:text>
                <xsl:value-of select="abbreviation"/>
                <xsl:text>)</xsl:text>
            </xsl:if>
            <xsl:if test="@priority='high'">
                <span class="priority-badge">★ ПРИОРИТЕТНЫЙ</span>
            </xsl:if>
        </h4>
        
        <p><strong>Декан:</strong> <xsl:value-of select="dean"/></p>
        <p><strong>Год основания факультета:</strong> <xsl:value-of select="established"/></p>
        
        <xsl:if test="departments">
            <div class="departments">
                <h5>Кафедры (<xsl:value-of select="count(departments/department)"/>):</h5>
                <xsl:apply-templates select="departments/department"/>
            </div>
        </xsl:if>
        
        <xsl:if test="specializations">
            <div class="specializations">
                <h5>Специализации:</h5>
                <ul>
                    <xsl:for-each select="specializations/specialization">
                        <li><xsl:value-of select="."/></li>
                    </xsl:for-each>
                </ul>
            </div>
        </xsl:if>
    </div>
</xsl:template>

<xsl:template match="department">
    <div class="department">
        <h6>
            <xsl:value-of select="name"/>
            <xsl:if test="@code">
                (код: <xsl:value-of select="@code"/>)
            </xsl:if>
        </h6>
        <p><strong>Заведующий:</strong> <xsl:value-of select="head"/></p>
        <p><strong>Количество студентов:</strong> <xsl:value-of select="student_count"/></p>
    </div>
</xsl:template>

<xsl:template match="photo">
    <div class="photo-item">
        <h5><xsl:value-of select="title"/></h5>
        <xsl:if test="@category='fitiks'">
            <div style="color: #007acc; font-weight: bold;">ФИТиКС</div>
        </xsl:if>
        <xsl:if test="@category='campus'">
            <div style="color: #228b22; font-weight: bold;">Кампус</div>
        </xsl:if>
        <img src="{file_path}" alt="{title}" width="180" height="120" style="border: 1px solid #ccc;"/>
        <p><xsl:value-of select="description"/></p>
        <p><small>Год: <xsl:value-of select="year"/></small></p>
    </div>
</xsl:template>

<xsl:template match="achievement">
    <div class="achievement">
        <h5><xsl:value-of select="title"/> (<xsl:value-of select="@year"/>)</h5>
        <p><xsl:value-of select="description"/></p>
        <p><small>Категория: <xsl:value-of select="@category"/></small></p>
    </div>
</xsl:template>

</xsl:stylesheet>
