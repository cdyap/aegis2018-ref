// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require turbolinks
//= require moment 
//= require fullcalendar
//= require_tree .



$('.admins.students').ready(function(){
	$('#search_student').on('input', function() {
	    var value = $(this).val();
	    var length = value.toString().length;
	    
	    if(length == 6) {
	      $.ajax({
	        method: 'GET',
	        url: '/students/admin_search',
	        data: { id: value },
	        dataType: 'json',
	        success: function(student) {
	        	if (student != null) {
	            	$('#student-name').text(student.name);	
		            $('#student-yrcrs').text(student.yr + " - " + student.course);
		            $('#student-school').text(student.school);
		            $('#student-account').text(student.account);
		            $('#student-yrbookpage').text(student.page_number);
		        } else {
		        	$('#student-name').text("Not found.");	
		        }
	          }
	      });   
	    } 
	    else {
	    	$('#student-name').text("");	
	        $('#student-yrcrs').text("");
	        $('#student-school').text("");
	        $('#student-account').text("");
	    }
	  }); 
});

$('.accounts.submit_writeup').ready(function(){
	$('#submit-final-writeup').attr("disabled", "disabled");
	$('#submit-final-writeup').addClass('disable-button');
	$('#terms-writeup').click(function() {
	    var $this = $(this);
 
	    if ($this.is(':checked')) {
	    	$('#submit-final-writeup').removeAttr("disabled", "disabled");
	    	$('#submit-final-writeup').removeClass('disable-button');
	    } else {
	    	$('#submit-final-writeup').attr("disabled", "disabled");
	    	$('#submit-final-writeup').addClass('disable-button');
	    }
	});

});

$('.admins.accounts').ready(function(){
	$('#search_account').on('input', function() {
	    var value = $(this).val();
	    var length = value.toString().length;

	    if(length == 5 || length == 6) {
	      $.ajax({
	        method: 'GET',
	        url: '/accounts/search',
	        data: { id: value },
	        dataType: 'json',
	        success: function(student) {
	        	if (student.name != null){
	            	$('#student-name').text(student.name);	
		            $('#student-yrcrs').text(student.yr + " - " + student.course);
		            $('#student-school').text(student.school);
		            $('#student-account').text(student.account);
		            $('#student-email').text(student.email);
		            $('#student-timeslot').text(student.get_timeslot);
		            $('#edit-account-id').val(student.student_id);
	        	} else {
	        		$('#student-name').text("Not found");
	        	}
	          },
	          error:function(e) {
	          	$('#edit-account-id').val("");
		    	$('#student-name').text("Not found.");
		        $('#student-yrcrs').text("");
		        $('#student-school').text("");
		        $('#student-account').text("");
		        $('#student-email').text("");
		        $('#student-timeslot').text("");
	          }
	      });   
	    } 
	    else {
	    	$('#edit-account-id').val("");
	    	$('#student-name').text("Not found.");
	        $('#student-yrcrs').text("");
	        $('#student-school').text("");
	        $('#student-account').text("");
	        $('#student-email').text("");
	        $('#student-timeslot').text("");
	        // $('#student-writeup').text("");
	    }
	  }); 
});

$('.accounts.group_signups').ready(function(){
	$('.groupslot-confirm').attr("disabled", "disabled");

	$('.grpnm').on('input', function() {
		if ($(this).val().length > 0) {
			$(this).siblings(".groupslot-confirm").removeAttr("disabled");
		}
		else {
			$('.groupslot-confirm').attr("disabled", "disabled");
		}
	});
});



$('.registrations.new').ready(function () {
	var terms_read = false;
	var terms_accepted = false;
	$('#new-account-submit').attr("disabled", "disabled");
	$('#new-account-submit').addClass('disable-button');

	try {
		if ($('#account_name').val().length == 0) {
			$('#student-name').text("Student not found.");
			$('#student-yrcrs').text("");
			$('#student-school').text("");
			$('.for-hiding').addClass('hidden');
		} else {
			$('#student-name').text($('#account_name').val());
			$('#student-yrcrs').text($('#account_yr').val() + " - " + $('#account_course').val());
			$('#student-school').text($('#account_school').val());
			$('.for-hiding').removeClass('hidden');
		}
	} catch (sign_up_validation) {
		
	}

	$('#account_student_id').on('input', function() {
	    var value = $(this).val();
	    var length = value.toString().length;

	    if(length == 6) {
	      $.ajax({
	        method: 'GET',
	        url: '/students/search',
	        data: { id: value },
	        dataType: 'json',
	        success: function(student) {
	            if (student[0].name == "Account already created.") {
	            	$('#student-name').text(student[0].name);	
	            	$('#new-account-submit').attr("disabled", "disabled");
					$('#new-account-submit').addClass('disable-button');
					$('.for-hiding').addClass('hidden');
	            }
	            else {
		            $('#student-name').text(student[0].name);
		            $('#student-yrcrs').text(student[0].yr + " - " + student[0].course);
		            $('#student-school').text(student[0].school);

		            $('#account_name').val(student[0].name);
		            $('#account_yr').val(student[0].yr);
		            $('#account_course').val(student[0].course);
		            $('#account_school').val(student[0].school);
		            $('.for-hiding').removeClass('hidden');
		   //          $('input[type=submit]').attr("disabled", "false");
					// $('input[type=submit]').removeClass('disable-button');
	        	}
	          }
	      });
	            
	       
	    } else {
		    $('#student-name').text("Student not found.");
		    $('#student-yrcrs').text("");
		    $('#student-school').text("");

		    $('#account_name').val("");
	        $('#account_yr').val("");
	        $('#account_course').val("");
	        $('#account_school').val("");
	        $('#new-account-submit').attr("disabled", "disabled");
			$('#new-account-submit').addClass('disable-button');
			$('.for-hiding').addClass('hidden');
	    }	
	  }); 

	$('#terms-read').click(function() {
	    var $this = $(this);
  
	    if ($this.is(':checked')) {
	    	terms_read = true;
	    } else {
	    	terms_read = false;
	    }
	    activateSubmit();
	});

	$('#terms-accept').click(function() {
	    var $this = $(this);
  
	    if ($this.is(':checked')) {
	    	terms_accepted = true;
	    } else {
	    	terms_accepted = false;
	    }
	    activateSubmit();
	});

	function activateSubmit() {
		if ((terms_accepted) && (terms_read) && $('#student-name').text() != "Student not found." && $('#student-name').text() != "Account already created." && $('#account_email').val() != "" && $('#account_password').val() != "" && $('#account_password_confirmation').val() != "" ) {
			$('#new-account-submit').removeAttr("disabled");
			$('#new-account-submit').removeClass('disable-button');
		}
		else {
			$('#new-account-submit').attr("disabled", "disabled");
			$('#new-account-submit').addClass('disable-button');
		}
	}
});

$('.pages.index').ready(function(){
	$('#calendar').fullCalendar({
		events: '/events.json',
		eventRender: function(event, element) {
		    $(element).tooltip({title: event.title});             
		}
	});
});

$('.yearbook_preview').ready(function(){
	$('form').submit(function(e){
		

		if (($('#page_number').val()=="") || ($('#name').val()=="") || ($('#feedback').val()=="")) {
			e.preventDefault();
			$('#error').text("Please fill up all fields.");
		} 
	});
});


$(document).ready(function () {

	

	try {
		var menu = $('.sticky');
		var origOffsetY = menu.offset().top;	
	}
	catch(err) {

	}

	//https://jsfiddle.net/cse_tushar/Dxtyu/141/
	$('a[href^="#"]').on('click', function (x) {
        x.preventDefault();
        $(document).off("scroll");
        
        $('a').each(function () {
            $(this).parent().removeClass('active');
        })
        $(this).parent().addClass('active');
      
        var target = this.hash,
            menu = target;
        $target = $(target);
        $('html, body').stop().animate({
            'scrollTop': $target.offset().top-100
        }, 500, 'swing', function () {
            window.location.hash = target;
            $(document).on("scroll", onScroll);
            $(this).parent().addClass('active');
        });
    });
	

	function scroll() {
	    if ($(window).scrollTop() >= origOffsetY) {
	        $('.sticky').addClass('navbar-fixed-top');
	        $('#announcements').css("padding-top","70px");
	    } else {
	        $('.sticky').removeClass('navbar-fixed-top');
	        $('#announcements').css("padding-top","0px");
	    }

	    var scrollPos = $(document).scrollTop();
	    $('nav a').each(function () {
	        var currLink = $(this);
	        var refElement = $(currLink.attr("href"));
	        if (refElement.position().top <= scrollPos && refElement.position().top + refElement.height() > scrollPos) {
	            // $('#menu-center ul li a').removeClass("active");
	            currLink.parent().addClass("active");
	        }
	        else{
	            currLink.parent().removeClass("active");
	        }
	    });
	}


  	document.onscroll = scroll;

});


$('.accounts.add_writeup').ready(function(){
	var text_max = 500;
	var originaltext = $('.writeup').text();

    $('.cws').html(text_max - ($('.writeup').val().length) + ' characters remaining');

    $('.writeup').keyup(function() {
        var text_length = $('.writeup').val().length;
        var text_remaining = text_max - text_length;

        $('.cws').html(text_remaining + ' characters remaining');

        if (text_remaining < 0) {
        	$('#writeup-submit').prop('disabled', true);
        }
        else {
        	$('#writeup-submit').prop('disabled', false);
        }
    });


    $('#genericwriteup,#emptywriteup').click(function(){
    	$('.writeup').attr("readonly","readonly"); 
    });

    $('#genericwriteup').click(function(){
    	$('.writeup').text("[GENERIC]");
    	$('.cws').css("visibility", "hidden");
    });

    $('#emptywriteup').click(function(){
    	$('.writeup').text("[EMPTY]");
    	$('.cws').css("visibility", "hidden");
    });

    $('#originalwriteup').click(function(){
    	$('.writeup').removeAttr("readonly");
    	switch (originaltext) {
	    	case "[GENERIC]":
	    		$('.writeup').text("");
	    		break;
	    	case "[EMPTY]":
	    		$('.writeup').text("");
	    		break;
	    	default: 
	    		$('.writeup').text(originaltext);
	    		break;
	    }
    	
    	$('.cws').css("visibility", "visible");
    });

     switch ($('.writeup').text()) {
    	case "[GENERIC]":
    		$('#genericwriteup').click();
    		break;
    	case "[EMPTY]":
    		$('#emptywriteup').click();
    		break;
    	default: 
    		$('#originalwriteup').click();
    		break;
    }

    $('#writeup-modal').on('show.bs.modal', function (e) {
    	text = $('.writeup').val().replace(/\n\r?/g, '<br>');
		$('#writeup-preview p').html(text);
	})

});