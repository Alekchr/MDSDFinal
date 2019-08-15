/*
 * generated by Xtext 2.17.0
 */
package org.xtext.example.mydsl.validation
import org.eclipse.xtext.validation.Check
import org.xtext.example.mydsl.anislide.Template
import org.xtext.example.mydsl.anislide.AnislidePackage
import org.xtext.example.mydsl.anislide.ProgressBody
import org.xtext.example.mydsl.anislide.SlideBody
import org.xtext.example.mydsl.anislide.BackgroundColor
import org.xtext.example.mydsl.anislide.Textcolor
import java.util.List
import java.util.Arrays
import org.xtext.example.mydsl.anislide.Style

/**
 * This class contains custom validation rules. 
 *
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#validation
 */
class AnislideValidator extends AbstractAnislideValidator {
	
	public static val INVALID_NAME = 'invalidName'
	public static val MISSING_ENTITY = 'missingEntity'
	int count;
	
	@Check
		def checkTemplateNamesStartWithCapital(Template template) {
			if (!Character.isUpperCase(template.name.charAt(0))) {
				warning("Template names should start with a capital letter", AnislidePackage.Literals.TEMPLATE__NAME,
				INVALID_NAME)
		}
	}
	@Check
		def checkOnlyOneProgressType(ProgressBody progressbody) {
			count = 0;
			for (entity : progressbody.progressentities){
				count++;
				if(entity.key == 'type:') {
					if (count > 1) {
					warning("You can only have one type", AnislidePackage.Literals.PROGRESS_BODY__PROGRESSENTITIES, INVALID_NAME)
					}
				}
			}
		}
	@Check
		def checkTitleExists(SlideBody slidebody) {
			for (entity : slidebody.slideentities) {
				if (entity.toString.contains('title:')) {
					return;
				 }
			 	else {
					warning("You need to provide a title", AnislidePackage.Literals.SLIDE_BODY__SLIDEENTITIES, MISSING_ENTITY)	
				}
			}
		}
	
	BackgroundColor bgColor
	Textcolor textColor
	String str = ''
	List<String> list = Arrays.asList(str.split(","))
	@Check
	def checkRGBValues(Style style){
		if(style.key == "color:"){
			textColor = style as Textcolor
			list =  textColor.value.split(",")
			for(color : list)
				if(Float.parseFloat(color) >255 || Float.parseFloat(color) < 0)
				warning('The numbers should all be between 0 and 255', AnislidePackage.Literals.TEXTCOLOR__VALUE,'invalid number')
			}
		if(style.key =="background-color:"){
			bgColor = style as BackgroundColor
			list = bgColor.value.split(",")
			for(color : list)
				if(Float.parseFloat(color) >255 || Float.parseFloat(color) < 0)
				warning('The numbers should all be between 0 and 255', AnislidePackage.Literals.BACKGROUND_COLOR__VALUE,'invalid number')
		}
		return
	}
}