import { connect } from 'react-redux';

import UserRating from './user_rating';
import { fetchReviewsProfile } from '../../actions/current_user_actions';

const mapStateToProps = state => ({
  userProfile: state.userProfile
});

const mapDispatchToProps = dispatch => ({
  fetchReviewsProfile: () => dispatch(fetchReviewsProfile())
});

export default connect(mapStateToProps, mapDispatchToProps)(UserRating);
