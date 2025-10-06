{if !$user->_logged_in}
	<body data-hash-tok="{$session_hash['token']}" data-hash-pos="{$session_hash['position']}" {if $system['theme_mode_night']}data-bs-theme="dark" {/if} class="{if $system['theme_mode_night']}night-mode{/if} visitor n_chat {if $page == 'index' && !$system['newsfeed_public']}index-body{/if}" {if $page == 'profile' && $system['system_profile_background_enabled'] && $profile['user_profile_background']}style="background: url({$profile['user_profile_background']}) fixed !important; background-size: 100% auto;" {/if}>
{else}
    <body data-hash-tok="{$session_hash['token']}" data-hash-pos="{$session_hash['position']}" data-chat-enabled="{$user->_data['user_chat_enabled']}" {if $system['theme_mode_night']}data-bs-theme="dark" {/if} class="{if $system['theme_mode_night']}night-mode{/if} {if !$system['chat_enabled'] || $user->_data['user_privacy_chat'] == "me"}n_chat{/if}{if $system['activation_enabled'] && !$system['activation_required'] && !$user->_data['user_activated']} n_activated{/if}{if !$system['system_live']} n_live{/if}" {if $page == 'profile' && $system['system_profile_background_enabled'] && $profile['user_profile_background']}style="background: url({$profile['user_profile_background']}) fixed !important; background-size: 100% auto;" {/if} {if $url}onload="initialize_scraper()" {/if}>
    {/if}
		<!-- main wrapper -->
		<div class="main-wrapper">
			{if $user->_logged_in && $system['activation_enabled'] && !$system['activation_required'] && !$user->_data['user_activated']}
				<!-- top-bar -->
				<div class="top-bar position-fixed text-dark">
					<div class="{if $system['fluid_design']}container-fluid{else}container{/if}">
						<div class="row">
							<div class="col-sm-7 d-none d-sm-block">
								{if $system['activation_type'] == "email"}
									{__("Please go to")} <span class="main fw-medium">{$user->_data['user_email']}</span> {__("to complete the activation process")}.
								{else}
									{__("Please check the SMS on your phone")} <strong>{$user->_data['user_phone']}</strong> {__("to complete the activation process")}.
								{/if}
							</div>
							<div class="col-sm-5 text-md-end">
								{if $system['activation_type'] == "email"}
									<span class="btn btn-main btn-sm" data-toggle="modal" data-url="core/activation_email_resend.php">
										{__("Resend Verification Email")}
									</span>
									<span class="mx-1"></span>
									<span class="btn btn-main btn-sm" data-toggle="modal" data-url="#activation-email-reset">
										{__("Change Email")}
									</span>
								{else}
									<span class="btn btn-main btn-sm" data-toggle="modal" data-url="#activation-phone">{__("Enter Code")}</span>
									{if $user->_data['user_phone']}
										<span class="mx-1"></span>
										<span class="btn btn-main btn-sm" data-toggle="modal" data-url="core/activation_phone_resend.php">
											{__("Resend SMS")}
										</span>
									{/if}
									<span class="mx-1"></span>
									<span class="btn btn-main btn-sm" data-toggle="modal" data-url="#activation-phone-reset">
										{__("Change Phone Number")}
									</span>
								{/if}
							</div>
						</div>
					</div>
				</div>
				<!-- top-bar -->
			{/if}
			
			{if !$system['system_live']}
				<!-- top-bar alert-->
				<div class="top-bar position-fixed text-white danger">
					<div class="{if $system['fluid_design']}container-fluid{else}container{/if}">
						<i class="fa fa-exclamation-triangle fa-lg pr5"></i>
						<span class="d-none d-sm-inline">{__("The system has been shut down")}.</span>
						<span>{__("Turn it on from")}</span> <a href="{$system['system_url']}/admincp/settings">{__("Admin Panel")}</a>
					</div>
				</div>
				<!-- top-bar alert-->
			{/if}
			
			{if $user->_login_as}
				<!-- bottom-bar alert-->
				<div class="bottom-bar position-fixed">
					<div class="container rounded-4 text-white p-2 p-md-3 d-flex align-items-center gap-2 gap-md-3 logged-as-container">
						<span class="flex-0">{__("You are currently logged in as")} <a href="{$system['system_url']}/{$user->_data['user_name']}">{$user->_data['user_fullname']}</a></span>
						<button class="btn btn-sm btn-warning flex-0 js_login-as" data-handle="revoke">
							{__("Switch Back")}
						</button>
					</div>
				</div>
				<!-- bottom-bar alert-->
			{/if}

			<!-- container -->
			<div class="{if $page != "app_oauth" && $page != "sign" && $page != "reset"}{if !$user->_logged_in && !$system['newsfeed_public'] && $page == "index"}{else}{if $system['fluid_design']}container-fluid x_cf_p{else}{if $page == "admin"}container-fluid x_cf_p{else}container{/if}{/if}{/if}{/if}">

				<!-- row -->
				<div class="row m-0">
					<!-- main-header -->
					{if $page != "app_oauth" && $page != "sign" && $page != "reset"}
						{if $page != "index" || ($user->_logged_in || $system['newsfeed_public'])}
						<div class="p-0 flex-0 x-sidebar-width">
							<div class="position-fixed h-100 x-sidebar-fixed">
								<div class="px-2 d-flex flex-column justify-content-between h-100 x-sidebar">
									<div class="position-relative main-header">
										<!-- logo-wrapper -->
										<div class="position-relative overflow-hidden logo-wrapper mobile-only" onclick="toggleMobileUserMenu()">
											<span>
												{$user->_data['user_fullname']}
											</span>
											<svg class="svg-icon size-full" viewBox="0 0 24 24" width="24" height="24" fill="none" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" clip-rule="evenodd" d="M5.29289 8.29289C5.68342 7.90237 6.31658 7.90237 6.70711 8.29289L12 13.5858L17.2929 8.29289C17.6834 7.90237 18.3166 7.90237 18.7071 8.29289C19.0976 8.68342 19.0976 9.31658 18.7071 9.70711L12.7071 15.7071C12.3166 16.0976 11.6834 16.0976 11.2929 15.7071L5.29289 9.70711C4.90237 9.31658 4.90237 8.68342 5.29289 8.29289Z" fill="currentColor"></path></svg>
										</div>
										<!-- logo-wrapper -->
										
		
<!-- Меню (по умолчанию скрыто) -->
<div class="mobile-menu-backdrop" id="menuBackdrop"></div>
<div class="mobile-menu" id="mobileMenu">
  <ul>
    <li><a class="btn btn-main w-100 dropdownMenuButton" href="#" data-bs-toggle="dropdown">
															<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24" color="currentColor" fill="none" class="x-hidden"><path d="M15.2141 5.98239L16.6158 4.58063C17.39 3.80646 18.6452 3.80646 19.4194 4.58063C20.1935 5.3548 20.1935 6.60998 19.4194 7.38415L18.0176 8.78591M15.2141 5.98239L6.98023 14.2163C5.93493 15.2616 5.41226 15.7842 5.05637 16.4211C4.70047 17.058 4.3424 18.5619 4 20C5.43809 19.6576 6.94199 19.2995 7.57889 18.9436C8.21579 18.5877 8.73844 18.0651 9.78375 17.0198L18.0176 8.78591M15.2141 5.98239L18.0176 8.78591" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" /><path d="M11 20H17" stroke="currentColor" stroke-width="2" stroke-linecap="round" /></svg>
															<span>{__("Create")}</span>
														</a></li>
    <li>Пункт 2</li>
  </ul>
</div>
										
										<div class="x_sidebar_links">
										
											<a href="{$system['system_url']}" class="zi9999 d-block py-1 body-color x_side_links {if $page == "index" && $view == ""}  {/if}">
												<div class="d-inline-flex align-items-center position-relative main_bg_half">
													<svg class="svg-icon size-full" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" width="27" height="27"><path fill-rule="evenodd" clip-rule="evenodd" d="M10.4864 3.16443C10.5772 2.61966 10.2091 2.10444 9.66437 2.01364C9.1196 1.92285 8.60437 2.29086 8.51358 2.83564L7.81952 7H3.5C2.94772 7 2.5 7.44772 2.5 8C2.5 8.55228 2.94772 9 3.5 9H7.48619L6.48619 15H2.5C1.94772 15 1.5 15.4477 1.5 16C1.5 16.5523 1.94772 17 2.5 17H6.15285L5.51358 20.8356C5.42278 21.3804 5.7908 21.8956 6.33557 21.9864C6.88034 22.0772 7.39557 21.7092 7.48637 21.1644L8.18044 17H14.1529L13.5136 20.8356C13.4228 21.3804 13.7908 21.8956 14.3356 21.9864C14.8803 22.0772 15.3956 21.7092 15.4864 21.1644L16.1804 17H19.5C20.0523 17 20.5 16.5523 20.5 16C20.5 15.4477 20.0523 15 19.5 15H16.5138L17.5138 9H20.5C21.0523 9 21.5 8.55228 21.5 8C21.5 7.44772 21.0523 7 20.5 7H17.8471L18.4864 3.16443C18.5772 2.61966 18.2091 2.10444 17.6644 2.01364C17.1196 1.92285 16.6044 2.29086 16.5136 2.83564L15.8195 7H9.84711L10.4864 3.16443ZM14.4862 15L15.4862 9H9.51377L8.51377 15H14.4862Z" fill="currentColor"></path></svg>
													<span class="text">Лента</span>
												</div>
											</a>
											
											<!-- notifications -->
											{include file='_header.notifications.tpl'}
											<!-- notifications -->

											{if $user->_logged_in}
												<!-- messages -->
												{if $system['chat_enabled'] && $user->_data['user_privacy_chat'] != "me"}
													{include file='_header.messages.tpl'}
												{/if}
												<!-- messages -->
												
												<!-- new post -->
												<div class="d-none body-color x_side_links mobi_display openmenu" >
													<svg class="svg-icon size-6" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" width="27" height="27">
													  <path d="M8 3H6.2C5.0799 3 4.51984 3 4.09202 3.21799C3.71569 3.40973 3.40973 3.71569 3.21799 4.09202C3 4.51984 3 5.0799 3 6.2V8M8 21H6.2C5.0799 21 4.51984 21 4.09202 20.782C3.71569 20.5903 3.40973 20.2843 3.21799 19.908C3 19.4802 3 18.9201 3 17.8V16M21 8V6.2C21 5.0799 21 4.51984 20.782 4.09202C20.5903 3.71569 20.2843 3.40973 19.908 3.21799C19.4802 3 18.9201 3 17.8 3H16M21 16V17.8C21 18.9201 21 19.4802 20.782 19.908C20.5903 20.2843 20.2843 20.5903 19.908 20.782C19.4802 21 18.9201 21 17.8 21H16M12 17L12 7M7 12H17" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
													</svg>
												</div>
												<!-- new post -->
												
												<a href="{$system['system_url']}/{$user->_data['user_name']}" class="d-none py-1 body-color x_side_links  {if $page == "events"}  {/if} mobi_display mob_user_btn">
													<div class="d-inline-flex align-items-center position-relative main_bg_half x_user_info ">
														<img src="{$user->_data['user_picture']}" alt="{$user->_data['user_fullname']}" class="rounded-circle flex-0">
														<span class="text">{__("Профиль")}</span>
													</div>
												</a>
												
											{/if}
											
											<!-- side panel -->
											{include file='_sidebar.tpl'}
											<!-- side panel -->
											
											
											
											{if $user->_logged_in}
												{if $user->_data['can_publish_posts'] || $user->_data['can_go_live'] || $user->_data['can_add_stories'] || $user->_data['can_write_blogs'] || $user->_data['can_sell_products'] || $user->_data['can_raise_funding'] || $user->_data['can_create_ads'] || $user->_data['can_create_pages'] || $user->_data['can_create_groups'] || $user->_data['can_create_events']}
													<!-- add-->
													<div class="dropup my-3 x_side_create">
														<a class="btn btn-main w-100 dropdownMenuButton d-none" href="#" data-bs-toggle="dropdown">
															<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24" color="currentColor" fill="none" class="x-hidden"><path d="M15.2141 5.98239L16.6158 4.58063C17.39 3.80646 18.6452 3.80646 19.4194 4.58063C20.1935 5.3548 20.1935 6.60998 19.4194 7.38415L18.0176 8.78591M15.2141 5.98239L6.98023 14.2163C5.93493 15.2616 5.41226 15.7842 5.05637 16.4211C4.70047 17.058 4.3424 18.5619 4 20C5.43809 19.6576 6.94199 19.2995 7.57889 18.9436C8.21579 18.5877 8.73844 18.0651 9.78375 17.0198L18.0176 8.78591M15.2141 5.98239L18.0176 8.78591" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" /><path d="M11 20H17" stroke="currentColor" stroke-width="2" stroke-linecap="round" /></svg>
															<span>{__("Create")}</span>
														</a>
														<!-- zover -->
														<div class="menu-overlay" id="menuOverlay"></div>
<!-- scripts consolidated below -->

														<div class="dropdown-menu x_side_create_menu">
															{if $user->_data['can_publish_posts']}
															  <div class="dropdown-item pointer" data-toggle="modal" data-url="posts/publisher.php">
																<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="20" height="20" color="currentColor" fill="none"><path d="M15.2141 5.98239L16.6158 4.58063C17.39 3.80646 18.6452 3.80646 19.4194 4.58063C20.1935 5.3548 20.1935 6.60998 19.4194 7.38415L18.0176 8.78591M15.2141 5.98239L6.98023 14.2163C5.93493 15.2616 5.41226 15.7842 5.05637 16.4211C4.70047 17.058 4.3424 18.5619 4 20C5.43809 19.6576 6.94199 19.2995 7.57889 18.9436C8.21579 18.5877 8.73844 18.0651 9.78375 17.0198L18.0176 8.78591M15.2141 5.98239L18.0176 8.78591" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round" /><path d="M11 20H17" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" /></svg>
																{__("Create Post")}
															  </div>
															{/if}
															{if $user->_data['can_go_live']}
															  <a class="dropdown-item" href="{$system['system_url']}/live">
																<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="20" height="20" color="currentColor" fill="none"><circle cx="12" cy="12" r="2" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"></circle><path d="M7.5 8C6.5 9 6 10.5 6 12C6 13.5 6.5 15 7.5 16" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"></path><path d="M4.5 6C3 7.5 2 9.5 2 12C2 14.5 3 16.5 4.5 18" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"></path><path d="M16.5 16C17.5 15 18 13.5 18 12C18 10.5 17.5 9 16.5 8" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"></path><path d="M19.5 18C21 16.5 22 14.5 22 12C22 9.5 21 7.5 19.5 6" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"></path></svg>
																{__("Create Live")}
															  </a>
															{/if}
															{if $user->_data['can_add_stories']}
															  <div class="dropdown-item pointer" data-toggle="modal" data-url="posts/story.php?do=create">
																<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="20" height="20" color="currentColor" fill="none"><path d="M12 22C6.47715 22 2.00004 17.5228 2.00004 12C2.00004 6.47715 6.47719 2 12 2C16.4777 2 20.2257 4.94289 21.5 9H19" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round" /><path d="M12 8V12L14 14" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round" /><path d="M21.9551 13C21.9848 12.6709 22 12.3373 22 12M15 22C15.3416 21.8876 15.6753 21.7564 16 21.6078M20.7906 17C20.9835 16.6284 21.1555 16.2433 21.305 15.8462M18.1925 20.2292C18.5369 19.9441 18.8631 19.6358 19.1688 19.3065" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round" /></svg>
																{__("Создать сторис")}
															  </div>
															{/if}
															{if $user->_data['can_write_blogs']}
															  <a class="dropdown-item userblogs-btn-mbl" href="{$system['system_url']}/blogs/new">
																<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="20" height="20" color="currentColor" fill="none"><path d="M10.5 8H18.5M10.5 12H13M18.5 12H16M10.5 16H13M18.5 16H16" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"></path><path d="M7 7.5H6C4.11438 7.5 3.17157 7.5 2.58579 8.08579C2 8.67157 2 9.61438 2 11.5V18C2 19.3807 3.11929 20.5 4.5 20.5C5.88071 20.5 7 19.3807 7 18V7.5Z" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"></path><path d="M16 3.5H11C10.07 3.5 9.60504 3.5 9.22354 3.60222C8.18827 3.87962 7.37962 4.68827 7.10222 5.72354C7 6.10504 7 6.57003 7 7.5V18C7 19.3807 5.88071 20.5 4.5 20.5H16C18.8284 20.5 20.2426 20.5 21.1213 19.6213C22 18.7426 22 17.3284 22 14.5V9.5C22 6.67157 22 5.25736 21.1213 4.37868C20.2426 3.5 18.8284 3.5 16 3.5Z" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"></path></svg>
																{__("Создать блог")}
															  </a>
															{/if}
															{if $user->_data['can_sell_products']}
															  <div class="dropdown-item pointer" data-toggle="modal" data-url="posts/product.php?do=create">
																<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="20" height="20" color="currentColor" fill="none"><path d="M3 10.5V15C3 17.8284 3 19.2426 3.87868 20.1213C4.75736 21 6.17157 21 9 21H12.5M21 10.5V12.5" stroke="currentColor" stroke-width="1.75" stroke-linecap="round"></path><path d="M7 17H11" stroke="currentColor" stroke-width="1.75" stroke-linecap="round"></path><path d="M15 18.5H22M18.5 22V15" stroke="currentColor" stroke-width="1.75" stroke-linecap="round"></path><path d="M17.7947 2.00254L6.14885 2.03002C4.41069 1.94542 3.96502 3.2116 3.96502 3.83056C3.96502 4.38414 3.88957 5.19117 2.82426 6.70798C1.75895 8.22478 1.839 8.67537 2.43973 9.72544C2.9383 10.5969 4.20643 10.9374 4.86764 10.9946C6.96785 11.0398 7.98968 9.32381 7.98968 8.1178C9.03154 11.1481 11.9946 11.1481 13.3148 10.8016C14.6376 10.4545 15.7707 9.2118 16.0381 8.1178C16.194 9.47735 16.6672 10.2707 18.0653 10.8158C19.5135 11.3805 20.7589 10.5174 21.3838 9.9642C22.0087 9.41096 22.4097 8.18278 21.2958 6.83288C20.5276 5.90195 20.2074 5.02494 20.1023 4.11599C20.0413 3.58931 19.9878 3.02336 19.5961 2.66323C19.0238 2.13691 18.2026 1.97722 17.7947 2.00254Z" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"></path></svg>
																{__("Создать услугу")}
															  </div>
															{/if}
															{if $user->_data['can_raise_funding']}
															  <div class="dropdown-item pointer" data-toggle="modal" data-url="posts/funding.php?do=create">
																<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="20" height="20" color="currentColor" fill="none"><path d="M19.5 16V12.0059C19.5 10.5195 19.5 9.77627 19.2444 9.09603C18.9888 8.4158 18.4994 7.85648 17.5206 6.73784L16 5H8L6.47939 6.73784C5.50058 7.85648 5.01118 8.4158 4.75559 9.09603C4.5 9.77627 4.5 10.5195 4.5 12.0059V16C4.5 18.8284 4.5 20.2426 5.37868 21.1213C6.25736 22 7.67157 22 10.5 22H13.5C16.3284 22 17.7426 22 18.6213 21.1213C19.5 20.2426 19.5 18.8284 19.5 16Z" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"></path><path d="M9.5 15.6831C9.5 16.9125 11.3539 17.9204 13.1325 17.3553C14.9112 16.7901 14.6497 15.1248 14.0463 14.4708C13.4429 13.8169 12.555 13.9265 11.5399 13.8751C9.25873 13.7594 9.09769 11.5722 10.9447 10.7069C12.2997 10.072 14.0379 10.8862 14.2381 12M11.971 9.5V10.4777M11.971 17.7204V18.5" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"></path><path d="M7.5 2H16.5C16.9659 2 17.1989 2 17.3827 2.07612C17.6277 2.17761 17.8224 2.37229 17.9239 2.61732C18 2.80109 18 3.03406 18 3.5C18 3.96594 18 4.19891 17.9239 4.38268C17.8224 4.62771 17.6277 4.82239 17.3827 4.92388C17.1989 5 16.9659 5 16.5 5H7.5C7.03406 5 6.80109 5 6.61732 4.92388C6.37229 4.82239 6.17761 4.62771 6.07612 4.38268C6 4.19891 6 3.96594 6 3.5C6 3.03406 6 2.80109 6.07612 2.61732C6.17761 2.37229 6.37229 2.17761 6.61732 2.07612C6.80109 2 7.03406 2 7.5 2Z" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"></path></svg>
																{__("Create Funding")}
															  </div>
															{/if}
															{if $user->_data['can_create_ads']}
															  <a class="dropdown-item ads-btn-mbl" href="{$system['system_url']}/ads/new">
																<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="20" height="20" color="currentColor" fill="none"><path d="M14.9263 2.91103L8.27352 6.10452C7.76151 6.35029 7.21443 6.41187 6.65675 6.28693C6.29177 6.20517 6.10926 6.16429 5.9623 6.14751C4.13743 5.93912 3 7.38342 3 9.04427V9.95573C3 11.6166 4.13743 13.0609 5.9623 12.8525C6.10926 12.8357 6.29178 12.7948 6.65675 12.7131C7.21443 12.5881 7.76151 12.6497 8.27352 12.8955L14.9263 16.089C16.4534 16.8221 17.217 17.1886 18.0684 16.9029C18.9197 16.6172 19.2119 16.0041 19.7964 14.778C21.4012 11.4112 21.4012 7.58885 19.7964 4.22196C19.2119 2.99586 18.9197 2.38281 18.0684 2.0971C17.217 1.8114 16.4534 2.17794 14.9263 2.91103Z" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"></path><path d="M11.4581 20.7709L9.96674 22C6.60515 19.3339 7.01583 18.0625 7.01583 13H8.14966C8.60978 15.8609 9.69512 17.216 11.1927 18.197C12.1152 18.8012 12.3054 20.0725 11.4581 20.7709Z" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"></path><path d="M7.5 12.5V6.5" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"></path></svg>
																{__("Реклама")}
															  </a>
															{/if}
															{if $user->_data['can_create_pages']}
															  <div class="dropdown-item pointer" data-toggle="modal" data-url="modules/add.php?type=page">
																<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="20" height="20" color="currentColor" fill="none"><path d="M15.8785 3L10.2827 3C7.32099 3 5.84015 3 4.92007 3.87868C4 4.75736 4 6.17157 4 9L4.10619 15L15.8785 15C18.1016 15 19.2131 15 19.6847 14.4255C19.8152 14.2666 19.9108 14.0841 19.9656 13.889C20.1639 13.184 19.497 12.3348 18.1631 10.6364L18.1631 10.6364C17.6083 9.92985 17.3309 9.57659 17.2814 9.1751C17.2671 9.05877 17.2671 8.94123 17.2814 8.8249C17.3309 8.42341 17.6083 8.07015 18.1631 7.36364L18.1631 7.36364C19.497 5.66521 20.1639 4.816 19.9656 4.11098C19.9108 3.91591 19.8152 3.73342 19.6847 3.57447C19.2131 3 18.1016 3 15.8785 3L15.8785 3Z" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"></path><path d="M4 21L4 8" stroke="currentColor" stroke-width="1.75" stroke-linecap="round"></path></svg>
																{__("Create Page")}
															  </div>
															{/if}
															{if $user->_data['can_create_groups']}
															  <div class="dropdown-item pointer groups-btn-mbl" data-toggle="modal" data-url="modules/add.php?type=group">
																<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="20" height="20" color="currentColor" fill="none"><path d="M7.5 19.5C7.5 18.5344 7.82853 17.5576 8.63092 17.0204C9.59321 16.3761 10.7524 16 12 16C13.2476 16 14.4068 16.3761 15.3691 17.0204C16.1715 17.5576 16.5 18.5344 16.5 19.5" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"></path><circle cx="12" cy="11" r="2.5" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"></circle><path d="M17.5 11C18.6101 11 19.6415 11.3769 20.4974 12.0224C21.2229 12.5696 21.5 13.4951 21.5 14.4038V14.5" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"></path><circle cx="17.5" cy="6.5" r="2" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"></circle><path d="M6.5 11C5.38987 11 4.35846 11.3769 3.50256 12.0224C2.77706 12.5696 2.5 13.4951 2.5 14.4038V14.5" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"></path><circle cx="6.5" cy="6.5" r="2" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"></circle></svg>
																{__("Create Group")}
															  </div>
															{/if}
															{if $user->_data['can_create_events']}
															  <div class="dropdown-item pointer event-btn-mbl" data-toggle="modal" data-url="modules/add.php?type=event">
																<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="20" height="20" color="currentColor" fill="none"><path d="M18 2V4M6 2V4" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"></path><path d="M11.9955 13H12.0045M11.9955 17H12.0045M15.991 13H16M8 13H8.00897M8 17H8.00897" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"></path><path d="M3.5 8H20.5" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"></path><path d="M2.5 12.2432C2.5 7.88594 2.5 5.70728 3.75212 4.35364C5.00424 3 7.01949 3 11.05 3H12.95C16.9805 3 18.9958 3 20.2479 4.35364C21.5 5.70728 21.5 7.88594 21.5 12.2432V12.7568C21.5 17.1141 21.5 19.2927 20.2479 20.6464C18.9958 22 16.9805 22 12.95 22H11.05C7.01949 22 5.00424 22 3.75212 20.6464C2.5 19.2927 2.5 17.1141 2.5 12.7568V12.2432Z" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"></path><path d="M3 8H21" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"></path></svg>
																{__("Create Event")}
															  </div>
															{/if}

															  <a class="dropdown-item ads-btn-mbl" href="{$system['system_url']}/jobs">
																<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="20" height="20" color="currentColor" fill="none"><path d="M3 11L3.15288 14.2269C3.31714 17.6686 3.39927 19.3894 4.55885 20.4447C5.71843 21.5 7.52716 21.5 11.1446 21.5H12.8554C16.4728 21.5 18.2816 21.5 19.4412 20.4447C20.6007 19.3894 20.6829 17.6686 20.8471 14.2269L21 11" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"></path><path d="M2.84718 10.4431C4.54648 13.6744 8.3792 15 12 15C15.6208 15 19.4535 13.6744 21.1528 10.4431C21.964 8.90056 21.3498 6 19.352 6H4.648C2.65023 6 2.03603 8.90056 2.84718 10.4431Z" stroke="currentColor" stroke-width="1.75"></path><path d="M11.9999 11H12.0089" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"></path><path d="M15.9999 6L15.9116 5.69094C15.4716 4.15089 15.2516 3.38087 14.7278 2.94043C14.204 2.5 13.5083 2.5 12.1168 2.5H11.8829C10.4915 2.5 9.79575 2.5 9.27198 2.94043C8.7482 3.38087 8.52819 4.15089 8.08818 5.69094L7.99988 6" stroke="currentColor" stroke-width="1.75"></path></svg>
																{__("Работа")}
															  </a>

														</div>
													</div>
													<!-- add -->
												{/if}
											{/if}
										</div>
									</div>
						
									<!-- user-menu -->
									<div class="py-1 x_user_mobi_menu">

										<div class="dropup ">
											{include file='_user_menu.tpl'}
										</div>
										

									</div>
									<!-- user-menu -->
								</div>
							</div>
						</div>
						{/if}
					{/if}
					<!-- main-header -->

					<!-- right column -->
					<div class="p-0 flex-0 {if $page != "app_oauth" && $page != "sign" && $page != "reset"}{if !$user->_logged_in && !$system['newsfeed_public'] && $page == "index"}{else}x-content-width{/if}{/if}">
						<!-- ads -->
						{include file='_ads.tpl' _ads=$ads_master['header'] _master=true}
						<!-- ads -->

						<script>
(function () {
  const onDomReady = () => {
    const overlay = document.getElementById('menuOverlay');
    const menu = document.querySelector('.dropdown-menu.x_side_create_menu');
    const trigger = document.querySelector('.dropdownMenuButton');
    if (!menu) return;

    const body = document.body;

    const setAriaExpanded = (expanded) => {
      if (trigger) {
        trigger.classList.toggle('show', expanded);
        trigger.setAttribute('aria-expanded', String(expanded));
      }
    };

    const openCreateMenu = () => {
      setAriaExpanded(true);

      menu.classList.add('show', 'fixed-center');
      menu.style.position = 'fixed';
      menu.style.left = '50%';
      menu.style.bottom = '48px';
      menu.style.transform = 'translateX(-50%)';
      menu.style.zIndex = '1050';
      menu.style.display = 'block';
      menu.style.width = '100%';

      if (overlay) {
        overlay.style.display = 'block';
        overlay.style.opacity = '0.5';
      }
      body.style.overflow = 'hidden';

      const firstItem = menu.querySelector('.dropdown-item, [data-toggle="modal"], a, button');
      if (firstItem && typeof firstItem.focus === 'function') {
        firstItem.focus();
      }
    };

    const closeCreateMenu = () => {
      setAriaExpanded(false);
      menu.classList.remove('show', 'fixed-center');
      menu.style.display = 'none';
      if (overlay) overlay.style.display = 'none';
      body.style.overflow = '';
    };

    const isMenuOpen = () => menu.classList.contains('show') || menu.style.display === 'block';

    const toggleCreateMenu = () => {
      if (isMenuOpen()) {
        closeCreateMenu();
      } else {
        openCreateMenu();
      }
    };

    document.addEventListener('click', (e) => {
      const clickedOpenDiv = e.target.closest('.openmenu');
      const clickedTrigger = trigger && (e.target === trigger || trigger.contains(e.target));

      if (clickedOpenDiv || clickedTrigger) {
        e.preventDefault();
        toggleCreateMenu();
        return;
      }

      if (overlay && e.target === overlay) {
        closeCreateMenu();
        return;
      }

      if (isMenuOpen()) {
        const clickedInsideMenu = menu.contains(e.target);
        const clickedInsideTrigger = trigger && trigger.contains(e.target);
        if (!clickedInsideMenu && !clickedInsideTrigger) {
          closeCreateMenu();
        }
      }
    });

    document.addEventListener('keydown', (e) => {
      if (e.key === 'Escape' && isMenuOpen()) {
        closeCreateMenu();
      }
    });
  };

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', onDomReady);
  } else {
    onDomReady();
  }

  window.toggleMobileUserMenu = function toggleMobileUserMenu() {
    const menu = document.getElementById('mobile-user-menu');
    if (!menu) return;
    const isHidden = menu.classList.contains('hidden');
    if (isHidden) {
      menu.classList.remove('hidden');
      document.body.style.overflow = 'hidden';
    } else {
      menu.classList.add('hidden');
      document.body.style.overflow = '';
    }
  };

  window.closeMobileUserMenu = function closeMobileUserMenu() {
    const menu = document.getElementById('mobile-user-menu');
    if (menu) {
      menu.classList.add('hidden');
      document.body.style.overflow = '';
    }
  };

  document.addEventListener('click', function (e) {
    const menu = document.getElementById('mobile-user-menu');
    if (e.target === menu) {
      window.closeMobileUserMenu();
    }
  });

  window.logout = function logout() {
    window.location.href = '{$system["system_url"]}/sign/?do=signout';
  };
})();
						</script>

<!-- Mobile User Menu Overlay -->
<div id="mobile-user-menu" class="hidden">
    <div class="mobile-menu-container">
        <div class="mobile-menu-handle" onclick="closeMobileUserMenu()">
            <div class="mobile-menu-handle-bar"></div>
        </div>
        
        <div class="mobile-menu-content">
            <div class="mobile-menu-section">
                <div class="mobile-menu-group">
                    <a onclick="document.querySelector('a.userblogs-btn-mbl').click();" href="{$system['system_url']}/blogs" class="mobile-menu-item">
                        <span class="mobile-menu-item-text">{__("Статьи пользователей")}</span>
                        <span class="mobile-menu-item-icon">
                            <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M10.5 8H18.5M10.5 12H13M18.5 12H16M10.5 16H13M18.5 16H16" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"></path>
                                <path d="M7 7.5H6C4.11438 7.5 3.17157 7.5 2.58579 8.08579C2 8.67157 2 9.61438 2 11.5V18C2 19.3807 3.11929 20.5 4.5 20.5C5.88071 20.5 7 19.3807 7 18V7.5Z" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"></path>
                                <path d="M16 3.5H11C10.07 3.5 9.60504 3.5 9.22354 3.60222C8.18827 3.87962 7.37962 4.68827 7.10222 5.72354C7 6.10504 7 6.57003 7 7.5V18C7 19.3807 5.88071 20.5 4.5 20.5H16C18.8284 20.5 20.2426 20.5 21.1213 19.6213C22 18.7426 22 17.3284 22 14.5V9.5C22 6.67157 22 5.25736 21.1213 4.37868C20.2426 3.5 18.8284 3.5 16 3.5Z" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"></path>
                            </svg>
                        </span>
                    </a>
{if $system['points_enabled'] || $system['wallet_enabled']}
	{if $system['wallet_enabled']}
	                    <a href="{$system['system_url']}/wallet" class="mobile-menu-item">
	                        <span class="mobile-menu-item-text">{__("Кошелек")}</span>
	                        <span class="mobile-menu-item-icon">
	                            <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
	                                <path d="M16 7.99983V4.50048C16 3.66874 16 3.25287 15.8248 2.9973C15.6717 2.77401 15.4346 2.62232 15.1678 2.57691C14.8623 2.52493 14.4847 2.6992 13.7295 3.04775L4.85901 7.14182C4.18551 7.45267 3.84875 7.6081 3.60211 7.84915C3.38406 8.06225 3.21762 8.32238 3.1155 8.60966C3 8.93462 3 9.30551 3 10.0473V14.9998M16.5 14.4998H16.51M3 11.1998L3 17.7998C3 18.9199 3 19.48 3.21799 19.9078C3.40973 20.2841 3.71569 20.5901 4.09202 20.7818C4.51984 20.9998 5.07989 20.9998 6.2 20.9998H17.8C18.9201 20.9998 19.4802 20.9998 19.908 20.7818C20.2843 20.5901 20.5903 20.2841 20.782 19.9078C21 19.48 21 18.9199 21 17.7998V11.1998C21 10.0797 21 9.51967 20.782 9.09185C20.5903 8.71552 20.2843 8.40956 19.908 8.21782C19.4802 7.99983 18.9201 7.99983 17.8 7.99983L6.2 7.99983C5.0799 7.99983 4.51984 7.99983 4.09202 8.21781C3.7157 8.40956 3.40973 8.71552 3.21799 9.09185C3 9.51967 3 10.0797 3 11.1998ZM17 14.4998C17 14.776 16.7761 14.9998 16.5 14.9998C16.2239 14.9998 16 14.776 16 14.4998C16 14.2237 16.2239 13.9998 16.5 13.9998C16.7761 13.9998 17 14.2237 17 14.4998Z" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"></path>
	                            </svg>
	                        </span>
	                    </a>
	{/if}
{/if}
                    <a onclick="document.querySelector('.ads-btn-mbl').click();" href="{$system['system_url']}/ads" class="mobile-menu-item">
                        <span class="mobile-menu-item-text">{__("Реклама")}</span>
                        <span class="mobile-menu-item-icon">
                            <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M14.9263 2.91103L8.27352 6.10452C7.76151 6.35029 7.21443 6.41187 6.65675 6.28693C6.29177 6.20517 6.10926 6.16429 5.9623 6.14751C4.13743 5.93912 3 7.38342 3 9.04427V9.95573C3 11.6166 4.13743 13.0609 5.9623 12.8525C6.10926 12.8357 6.29178 12.7948 6.65675 12.7131C7.21443 12.5881 7.76151 12.6497 8.27352 12.8955L14.9263 16.089C16.4534 16.8221 17.217 17.1886 18.0684 16.9029C18.9197 16.6172 19.2119 16.0041 19.7964 14.778C21.4012 11.4112 21.4012 7.58885 19.7964 4.22196C19.2119 2.99586 18.9197 2.38281 18.0684 2.0971C17.217 1.8114 16.4534 2.17794 14.9263 2.91103Z" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"></path>
                                <path d="M11.4581 20.7709L9.96674 22C6.60515 19.3339 7.01583 18.0625 7.01583 13H8.14966C8.60978 15.8609 9.69512 17.216 11.1927 18.197C12.1152 18.8012 12.3054 20.0725 11.4581 20.7709Z" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"></path>
                                <path d="M7.5 12.5V6.5" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"></path>
                            </svg>
                        </span>
                    </a>

                    <a href="{$system['system_url']}/groups" class="mobile-menu-item">
                    	<span class="mobile-menu-item-text">Группы</span>
                    	<span class="mobile-menu-item-icon">
                    		<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="20" height="20" color="currentColor" fill="none"><path d="M7.5 19.5C7.5 18.5344 7.82853 17.5576 8.63092 17.0204C9.59321 16.3761 10.7524 16 12 16C13.2476 16 14.4068 16.3761 15.3691 17.0204C16.1715 17.5576 16.5 18.5344 16.5 19.5" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"></path><circle cx="12" cy="11" r="2.5" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"></circle><path d="M17.5 11C18.6101 11 19.6415 11.3769 20.4974 12.0224C21.2229 12.5696 21.5 13.4951 21.5 14.4038V14.5" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"></path><circle cx="17.5" cy="6.5" r="2" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"></circle><path d="M6.5 11C5.38987 11 4.35846 11.3769 3.50256 12.0224C2.77706 12.5696 2.5 13.4951 2.5 14.4038V14.5" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"></path><circle cx="6.5" cy="6.5" r="2" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"></circle></svg>
                    	</span>
                    </a>

                    <a href="{$system['system_url']}/events" class="mobile-menu-item">
                    	<span class="mobile-menu-item-text">Мероприятия</span>
                    	<span class="mobile-menu-item-icon">
                    		<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="20" height="20" color="currentColor" fill="none"><path d="M18 2V4M6 2V4" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"></path><path d="M11.9955 13H12.0045M11.9955 17H12.0045M15.991 13H16M8 13H8.00897M8 17H8.00897" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"></path><path d="M3.5 8H20.5" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"></path><path d="M2.5 12.2432C2.5 7.88594 2.5 5.70728 3.75212 4.35364C5.00424 3 7.01949 3 11.05 3H12.95C16.9805 3 18.9958 3 20.2479 4.35364C21.5 5.70728 21.5 7.88594 21.5 12.2432V12.7568C21.5 17.1141 21.5 19.2927 20.2479 20.6464C18.9958 22 16.9805 22 12.95 22H11.05C7.01949 22 5.00424 22 3.75212 20.6464C2.5 19.2927 2.5 17.1141 2.5 12.7568V12.2432Z" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"></path><path d="M3 8H21" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"></path></svg>
                    	</span>
                    </a>

                    

                    <button onclick="document.querySelector('.js_theme-mode').click(); closeMobileUserMenu();" class="mobile-menu-item">
                        <span class="mobile-menu-item-text">{__("Тема")}</span>
                        <span class="mobile-menu-item-icon">
                            <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M21.5 14.0784C20.3003 14.7189 18.9301 15.0821 17.4751 15.0821C12.7491 15.0821 8.91792 11.2509 8.91792 6.52485C8.91792 5.06986 9.28105 3.69968 9.92157 2.5C5.66675 3.49698 2.5 7.31513 2.5 11.8731C2.5 17.1899 6.8101 21.5 12.1269 21.5C16.6849 21.5 20.503 18.3332 21.5 14.0784Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                        </span>
                    </button>
                    <button onclick="document.querySelector('a.logout-btn-mbl').click();" class="mobile-menu-item logout">
                        <span class="mobile-menu-item-text">{__("Выйти")}</span>
                        <span class="mobile-menu-item-icon">
                            <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M16 17L21 12L16 7" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                <path d="M21 12H9" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                <path d="M9 21H5C3.89543 21 3 20.1046 3 19V5C3 3.89543 3.89543 3 5 3H9" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                        </span>
                    </button>
                </div>
            </div>
            
            <div class="mobile-menu-footer">
                <span class="mobile-menu-footer-text">
                    scladbt.ru © 2025
                </span>
            </div>
        </div>
    </div>
</div>